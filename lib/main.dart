import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/donnees.dart';
import 'package:weather/forecast.dart';
import 'package:weather/infos.dart';
import 'package:weather/weatherNow.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather',
      theme: ThemeData(
        fontFamily: "Ubuntu",
      ),
      home: const MyHomePage(title: 'Ma méteo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double lat = 0, lon = 0;
  bool loading = true;
  Donnees data = Donnees();

  _MyHomePageState() {
    getPosition();
  }

  void getPosition() async {
    bool serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (serviceEnable == false) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
            title: Text("Erreur"),
            content: Text("Localisation non disponible"),
          );
        },
      );
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              title: Text("ERREUR"),
              content: Text("Active la localisation"),
            );
          },
        );
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    lat = position.latitude;
    lon = position.longitude;
    data.getData(lat, lon, refresh);
  }

  void refresh() {
    loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: !loading
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  WeatherNow(data, getPosition),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Infos(data),
                  const SizedBox(
                    height: 16.0,
                  ),
                  ForecastWidget(data),
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
