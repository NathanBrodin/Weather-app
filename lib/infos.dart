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
          padding: const EdgeInsets.all(24.0),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xFF718EFE),
                Color(0xFF023C20),
              ],
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(32.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/infos-icons/Wind.png",
                      height: 32.0,),
              const Text(
                "Vent",
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w200, color: Colors.white),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Text(
                data.weather.wind,
                style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, color: Colors.white),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 8.0,
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(24.0),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                Color(0xFF718EFE),
                Color(0xFF023C20),],
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
                        Image.asset("assets/infos-icons/Sunrise.png",
                      height: 32.0,),
                        const Text(
                          "L. du soleil",
                          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w200, color: Colors.white),
                        ),
                        const SizedBox(height: 5.0,),
                        Text(
                          data.weather.sunrise,
                          style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, color: Colors.white),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset("assets/infos-icons/Sunset.png",
                      height: 32.0,),
                        const Text(
                          "C. du soleil",
                          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w200, color: Colors.white),
                        ),
                        const SizedBox(height: 5.0,),
                        Text(
                          data.weather.sunset,
                          style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, color: Colors.white),
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
