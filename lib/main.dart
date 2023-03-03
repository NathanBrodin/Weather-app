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
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
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
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(1.5),
                                child: Text(
                                  ((data.weather.time).split(" "))[0],
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(1.5),
                                child: Text(
                                  ((data.weather.time).split(" "))[1],
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(1.5),
                                child: Text(
                                  ((data.weather.time).split(" "))[2],
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 14.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: const AlignmentDirectional(1, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.weather.temp,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 64.0,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                data.weather.feel,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: const AlignmentDirectional(0, 0),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  data.weather.conditions,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      data.weather.city,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    IconButton(
                                        icon: const Icon(Icons.refresh_rounded,
                                            color: Colors.white),
                                        onPressed: getPosition),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(32.0),
                        decoration: const BoxDecoration(
                          color: Color(0xFF222A36),
                          borderRadius: BorderRadius.all(
                            Radius.circular(32.0),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.wind_power_rounded,
                              color: Colors.white,
                            ),
                            const Text(
                              "Vent",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              data.weather.wind,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(32.0),
                          decoration: const BoxDecoration(
                            color: Color(0xFF222A36),
                            borderRadius: BorderRadius.all(
                              Radius.circular(32.0),
                            ),
                          ),
                          alignment: const AlignmentDirectional(0, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(
                                Icons.wb_sunny,
                                color: Colors.white,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Lever du soleil",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        data.weather.sunrise,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.0),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Coucher du soleil",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        data.weather.sunset,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.0),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  const Text(
                    "Prévisions à 5 jours",
                    style: TextStyle(color: Colors.white, fontSize: 14.0),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Deroulement(data.forecast.length, data.forecast),
                    ),
                  ),
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
