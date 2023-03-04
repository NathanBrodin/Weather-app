import 'package:flutter/material.dart';

class WeatherNow extends StatelessWidget {
  dynamic data;
  dynamic getPosition;

  WeatherNow(this.data, this.getPosition, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    style: const TextStyle(color: Colors.white, fontSize: 14.0),
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
    );
  }
}
