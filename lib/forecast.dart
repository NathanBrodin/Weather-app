import 'package:flutter/material.dart';

class ForecastWidget extends StatelessWidget {
  dynamic forecast;

  ForecastWidget(this.forecast, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          top: 32.0, bottom: 32.0, left: 16.0, right: 16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: const BorderRadius.all(
          Radius.circular(32.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Prévision à 5 jours",
            style: Theme.of(context).textTheme.headlineLarge,
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
                      Text(
                        item.time,
                        style: const TextStyle(
                            fontSize: 14.0,
                            fontFamily: "Gilroy-Light",
                            color: Colors.white),
                      ),
                      Image.asset(
                        "assets/forecast-icons/${item.icon}.png",
                        height: 48.0,
                      ),
                      Text(
                        item.temp,
                        style: const TextStyle(
                            fontSize: 18.0,
                            fontFamily: "Gilroy-SemiBold",
                            color: Colors.white),
                      ),
                      Container(
                        width: 25.0,
                        height: 1.0,
                        color: Colors.grey.shade400,
                      ),
                      Text(
                        item.humidity,
                        style: TextStyle(
                            fontSize: 14.0,
                            fontFamily: "Gilroy-Light",
                            color: Colors.grey.shade400),
                      ),
                      Text(
                        item.conditions,
                        style: TextStyle(
                            fontSize: 14.0,
                            fontFamily: "Gilroy-Light",
                            color: Colors.grey.shade400),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Divider(
                    color: Colors.grey.shade700,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
