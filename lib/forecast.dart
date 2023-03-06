import 'package:flutter/material.dart';

class ForecastWidget extends StatelessWidget {
  dynamic forecast;

  ForecastWidget(this.forecast, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32.0),
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
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Image.asset(
                            "assets/forecast-icons/${item.icon}.png",
                            height: 32.0,
                          ),
                          Text(
                            item.temp,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      Container(width: 25.0, height: 1.0, color: Colors.grey,),
                      Row(
                        children: [
                          Text(
                            item.humidity,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            item.conditions,
                            style: Theme.of(context).textTheme.bodyMedium,
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
