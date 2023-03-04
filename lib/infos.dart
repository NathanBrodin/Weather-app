import 'package:flutter/material.dart';

class Infos extends StatelessWidget {
  dynamic data;

  Infos(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          padding: const EdgeInsets.all(32.0),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.blue,
                Colors.red,
              ],
            ),
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
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.blue,
                  Colors.red,
                ],
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(32.0),
              ),
            ),
            alignment: const AlignmentDirectional(0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.wb_sunny,
                          color: Colors.white,
                        ),
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
                              color: Colors.white, fontSize: 14.0),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.wb_sunny,
                          color: Colors.white,
                        ),
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
                              color: Colors.white, fontSize: 14.0),
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
    );
  }
}
