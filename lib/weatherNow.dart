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
          image: AssetImage("assets/backgrounds/1.png"),
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
                    style: const TextStyle(
                        fontSize: 20.0,
                        fontFamily: "Gilroy-Medium",
                        color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(1.5),
                  child: Text(
                    ((data.weather.time).split(" "))[1],
                    style: const TextStyle(
                        fontSize: 20.0,
                        fontFamily: "Gilroy-Medium",
                        color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(1.5),
                  child: Text(
                    ((data.weather.time).split(" "))[2],
                    style: const TextStyle(
                        fontSize: 20.0,
                        fontFamily: "Gilroy-Light",
                        color: Colors.white),
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
                  style: const TextStyle(
                      fontSize: 64.0,
                      fontFamily: "Gilroy-ExtraBold",
                      color: Colors.white),
                ),
                Text(
                  data.weather.feel,
                  style: const TextStyle(
                      fontSize: 16.0,
                      fontFamily: "Gilroy-SemiBold",
                      color: Colors.white),
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
                    style: const TextStyle(
                        fontSize: 20.0,
                        fontFamily: "Gilroy-Regular",
                        color: Colors.white),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        data.weather.city,
                        style: const TextStyle(
                            fontSize: 20.0,
                            fontFamily: "Gilroy-Medium",
                            color: Colors.white),
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
