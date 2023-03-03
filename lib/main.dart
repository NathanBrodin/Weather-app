import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather/deroulement.dart';
import 'package:weather/donnees.dart';

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
        primarySwatch: Colors.blue,
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
              content: Text("Active la localisation ou casse toi"),
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
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 400,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40.0)),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/backgrounds/sunset.png"),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              data.weather.time,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14.0),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Column(
                            children: [
                              Text(
                                data.weather.temp,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 64.0,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                data.weather.wind,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500),
                              ),
                              
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      !loading
                          ? Image.network(
                              "https://openweathermap.org/img/wn/${data.weather.icon}@2x.png")
                          : const Icon(
                              Icons.cloud,
                              size: 64,
                            ),
                      !loading
                          ? Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(children: [
                                Text(data.weather.city),
                                Text(data.weather.temp),
                                Text(data.weather.conditions),
                                Text(data.weather.humidity),
                                Text(data.weather.wind),
                              ]),
                            )
                          : const Text("Chargement...")
                    ],
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  !loading
                      ? Expanded(
                          child: SingleChildScrollView(
                            child: Deroulement(
                                data.forecast.length, data.forecast),
                          ),
                        )
                      : const Text("Chargement..."),
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: getPosition,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.replay),
      ),
    );
  }
}
