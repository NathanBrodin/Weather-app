import 'package:flutter/material.dart';

class WeatherNow extends StatelessWidget {
  dynamic data;
  dynamic getPosition;

  WeatherNow(this.data, this.getPosition, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(40.0)),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/backgrounds/4.png"),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 30.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.all(1.5),
                  child: Text(
                    ((data.weather.time).split(" "))[0],
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(1.5),
                  child: Text(
                    ((data.weather.time).split(" "))[1],
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(1.5),
                  child: Text(
                    ((data.weather.time).split(" "))[2],
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: const AlignmentDirectional(1, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  data.weather.temp,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  data.weather.feel,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
          Align(
            alignment: const AlignmentDirectional(0, 0),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data.weather.conditions,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        data.weather.city,
                        style: Theme.of(context).textTheme.headlineLarge,
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
    );
  }
}
