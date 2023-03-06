import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/donnees.dart';
import 'package:weather/forecast.dart';
import 'package:weather/infos.dart';
import 'package:weather/weatherNow.dart';

// TODO: Mettre en place un theme pour uniformiser le stye (texte...)
// TODO: Creer les images de fonds

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
        fontFamily: "Gilroy",
        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontSize: 76.0, fontWeight: FontWeight.w900, color: Colors.white),
          headlineMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.white),
          titleSmall: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.white),
          bodyLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.white),
          bodyMedium: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, color: Colors.white),
          bodySmall: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w300, color: Colors.grey),
        ),
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
      backgroundColor: const Color(0xFF1B1C1F),
      body: !loading
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomScrollView(
                  scrollBehavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  slivers: [
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: _MyHeaderDelegate(
                        minHeight: 220.0,
                        maxHeight: 450.0,
                        child: WeatherNow(data, getPosition),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate([
                        const SizedBox(
                          height: 8.0,
                        ),
                        Infos(data),
                        const SizedBox(
                          height: 8.0,
                        ),
                        ForecastWidget(data.forecast),
                      ]),
                    )
                  ]),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class _MyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _MyHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(covariant _MyHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
