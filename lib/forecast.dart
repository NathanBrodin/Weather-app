import 'package:flutter/material.dart';

class ForecastWidget extends StatelessWidget {
  dynamic forecast;

  ForecastWidget(this.forecast, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          top: 32.0, bottom: 32.0, left: 16.0, right: 16.0),
      decoration: const BoxDecoration(
        color: Color(0xFF212325),
        borderRadius: BorderRadius.all(
          Radius.circular(32.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Prévision à 5 jours",
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
                color: Colors.white),
          ),
          const SizedBox(
            height: 16.0,
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: forecast.length,
            itemBuilder: (context, index) {
              final item = forecast[index];
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            item.time,
                            style: const TextStyle(
                                fontSize: 14.0,
                                fontFamily: "Gilroy-Thin",
                                color: Colors.white),
                          ),
                          Image.asset(
                            "assets/forecast-icons/${item.icon}.png",
                            height: 32.0,
                          ),
                          Text(
                            item.temp,
                            style: const TextStyle(
                                fontSize: 16.0,
                                fontFamily: "Gilroy-SemiBold",
                                color: Colors.white),
                          ),
                        ],
                      ),
                      Container(
                        width: 25.0,
                        height: 1.0,
                        color: Colors.grey,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            item.humidity,
                            style: const TextStyle(
                                fontSize: 12.0,
                                fontFamily: "Gilroy-Thin",
                                color: Colors.grey),
                          ),
                          Text(
                            item.conditions,
                            style: const TextStyle(
                                fontSize: 12.0,
                                fontFamily: "Gilroy-Thin",
                                color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  const Divider(),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
