import 'package:flutter/material.dart';
import 'package:weather/deroulement.dart';

class ForecastWidget extends StatelessWidget {
  dynamic data;

  ForecastWidget(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Deroulement(data.forecast.length, data.forecast),
      ),
    );
  }
}
