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
        colorScheme: const ColorScheme(
            brightness: Brightness.dark,
            primary: Colors.white,
            onPrimary: Colors.white,
            secondary: Color(0xFF212325),
            onSecondary: Color(0xFF212325),
            error: Colors.white,
            onError: Colors.white,
            background: Color(0xFF1B1D1F),
            onBackground: Color(0xFF1B1D1F),
            surface: Colors.black,
            onSurface: Colors.black),
        fontFamily: "Gilroy",
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
              fontSize: 20.0, fontFamily: "Gilroy-Medium", color: Colors.white),
          headlineMedium: TextStyle(
              fontSize: 20.0,
              fontFamily: "Gilroy-Regular",
              color: Colors.white),
          headlineSmall: TextStyle(
              fontSize: 20.0, fontFamily: "Gilroy-Light", color: Colors.white),
          titleLarge: TextStyle(
              fontSize: 64.0,
              fontFamily: "Gilroy-ExtraBold",
              color: Colors.white),
          titleMedium: TextStyle(
              fontSize: 16.0,
              fontFamily: "Gilroy-SemiBold",
              color: Colors.white),
          bodyMedium: TextStyle(
              fontSize: 16.0, fontFamily: "Gilroy-Medium", color: Colors.white),
          bodySmall: TextStyle(
              fontSize: 16.0, fontFamily: "Gilroy-Light", color: Colors.white),
        ),
      ),
      home: const MyHomePage(title: 'Ma météo'),
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
    if (!serviceEnable) {
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return;
        }
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
      backgroundColor: Theme.of(context).colorScheme.background,
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
                        minHeight: 225.0,
                        maxHeight: 525.0,
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
