import 'package:timelines/timelines.dart';
import 'package:flutter/material.dart';

class Contenu extends StatelessWidget {
  String time;
  String icon;
  String temp;
  String humidity;
  String conditions;

  Contenu(this.time, this.icon, this.temp, this.humidity, this.conditions,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(time),
          const Text("Icon"),
          Text(temp),
          Text(humidity),
          Text(conditions),
        ],
      ),
    );
  }
}

class Oppose extends StatelessWidget {
  String time = "";
  Oppose(this.time, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Text(time),
    );
  }
}

class Connecteur extends StatelessWidget {
  const Connecteur({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 40.0,
      child: DecoratedLineConnector(
        decoration: BoxDecoration(color: Colors.blue),
      ),
    );
  }
}

class Indicateur extends StatelessWidget {
  String icon;

  Indicateur(this.icon, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(90),
        border: Border.all(color: Colors.blue, width: 3),
      ),
      child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.network(
              "https://openweathermap.org/img/wn/${icon}@2x.png")),
    );
  }
}

class Deroulement extends StatelessWidget {
  int itemCount = 0;
  dynamic forecast;

  Deroulement(this.itemCount, this.forecast, {super.key});

  @override
  Widget build(BuildContext context) {
    return FixedTimeline.tileBuilder(
      builder: TimelineTileBuilder.connected(
        itemCount: itemCount,
        contentsAlign: ContentsAlign.reverse,
        contentsBuilder: (context, index) {
          return Contenu(
              forecast[index].time,
              forecast[index].icon,
              forecast[index].temp,
              forecast[index].humidity,
              forecast[index].conditions);
        },
      ),
    );
  }
}
