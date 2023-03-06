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
              Text(
                "Vent",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                data.weather.wind,
                style: Theme.of(context).textTheme.bodyMedium,
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
                        Text(
                          "Lever du soleil",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          data.weather.sunrise,
                          style: Theme.of(context).textTheme.bodyMedium,
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
                        Text(
                          "Coucher du soleil",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          data.weather.sunset,
                          style: Theme.of(context).textTheme.bodyMedium,
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
