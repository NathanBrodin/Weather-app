import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

dynamic WeatherIcons = {
  "01d": "rainy-3.svg",
  "000": "rainy-4.svg",
  "000": "rainy-5.svg",
  "09d": "rainy-6.svg",
  "000": "rainy-7.svg",
  "13d": "snowy-1.svg",
  "000": "snowy-2.svg",
  "000": "snowy-3.svg",
  "000": "snowy-4.svg",
  "000": "snowy-5.svg",
  "000": "snowy-6.svg",
  "11d": "thunder.svg",
  "000": "weather.svg",
  "000": "weather_sagittarius.svg",
  "000": "weather_sunset.svg",
  "000": "weather-sprite.svg",
  "04d": "cloudy.svg",
  "02d": "cloudy-day-1.svg",
  "03d": "cloudy-day-2.svg",
  "000": "cloudy-day-3.svg",
  "02n": "cloudy-night-1.svg",
  "03n": "cloudy-night-2.svg",
  "000": "cloudy-night-3.svg",
  "01d": "day.svg",
  "01n": "night.svg",
  "10d": "rainy-1.svg",
  "000": "rainy-2.svg",
};

dynamic Conditions = {
  "200": "Orage et pluie fine",
  "201": "Orage et pluie",
  "202": "Orage et pluie intense",
  "210": "Quelques éclairs",
  "211": "Eclairs",
  "212": "Eclairs importants",
  "221": "Eclairs très nombreux",
  "230": "Eclairs et bruine fine",
  "231": "Eclairs et bruine",
  "232": "Eclairs et bruine forte",
  "300": "Bruine peu intense",
  "301": "Bruine",
  "302": "Bruine intense",
  "310": "Pluie fine faible",
  "311": "Pluie fine",
  "312": "Pluie fine intense",
  "313": "Bruine avec averses",
  "314": "Bruine avec fortes pluies",
  "321": "Averses de bruine",
  "500": "Faibles pluies",
  "501": "Pluie",
  "502": "Fortes pluies",
  "503": "Très fortes pluies",
  "504": "Précipitations extrêmes",
  "511": "Pluies verglaçantes",
  "520": "Rares averses",
  "521": "Averses",
  "522": "Fortes averses",
  "531": "Très fortes averses",
  "600": "Quelques flocons",
  "601": "Chuttes de neige",
  "602": "Fortes chuttes de neige",
  "611": "Neige fondue",
  "612": "Rares averses de neige fondue",
  "613": "Averses de neige fondue",
  "615": "Neige et faibles pluies",
  "616": "Neige et pluie",
  "620": "Rares averses de neige",
  "621": "Averses de neige",
  "622": "Fortes averses de neige",
  "701": "Brume",
  "711": "Fumées",
  "721": "Brume",
  "731": "Tourbillons de poussières",
  "741": "Brouillard",
  "751": "Tempête de sable",
  "761": "Tempête de poussière",
  "762": "Cendre volcanique",
  "771": "Tempête",
  "781": "Tornades",
  "800": "Temps dégagé",
  "801": "Rares nuages",
  "802": "Nuages épars",
  "803": "Nuageux",
  "804": "Très nuageux",
};

dynamic Days = {
  "Monday": "Lundi",
  "Tuesday": "Mardi",
  "Wednesday": "Mercredi",
  "Thursday": "Jeudi",
  "Friday": "Vendredi",
  "Saturday": "Samedi",
  "Sunday": "Dimanche",
};

class Weather {
  String time;
  String city;
  String temp;
  String feel;
  String conditions;
  String sunrise;
  String sunset;
  String wind;
  String icon;

  Weather(this.time, this.city, this.temp, this.feel, this.conditions,
      this.sunrise, this.sunset, this.wind, this.icon);
}

class Forecast {
  String time;
  String temp;
  String conditions;
  String icon;

  Forecast(this.time, this.temp, this.conditions, this.icon);
}

class Donnees {
  double lat = 0, lon = 0;
  String? key = dotenv.env['OPENWEATHERKEY'];

  Weather weather = Weather("time", "city", "temp", "feel", "conditions",
      "sunrise", "sunset", "wind", "icon");
  List<Forecast> forecast = [];

  getData(double lat, double lon, dynamic cb) async {
    String latitude = lat.toString();
    String longitude = lon.toString();

    String urlWeather =
        "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$key";

    String urlForecast =
        "https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&appid=$key";

    Uri uriWeather = Uri.parse(urlWeather);
    Uri uriForecast = Uri.parse(urlForecast);

    final response = await http.get(uriWeather);
    if (response.statusCode != 200) return;

    final response2 = await http.get(uriForecast);
    if (response2.statusCode != 200) return;

    dynamic body = jsonDecode(response.body);
    dynamic bodyForecast = jsonDecode(response2.body);

    var data = body;
    var dataForecast = bodyForecast;

    int code = data["weather"][0]["id"];

    int timeStamp = int.parse(data["dt"].toString());
    int sunriseStamp = int.parse(data["sys"]["sunrise"].toString());
    int sunsetStamp = int.parse(data["sys"]["sunset"].toString());

    DateTime date = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    DateTime sunriseDate =
        DateTime.fromMillisecondsSinceEpoch(sunriseStamp * 1000);
    DateTime sunsetDate =
        DateTime.fromMillisecondsSinceEpoch(sunsetStamp * 1000);

    DateFormat dateFormat = DateFormat("d MMMM, EEEE");
    DateFormat hourFormat = DateFormat("HH:mm");

    String time = dateFormat.format(date);
    String sunrise = hourFormat.format(sunriseDate);
    String sunset = hourFormat.format(sunsetDate);

    weather = Weather(
      time,
      data["name"].toString(),
      (data["main"]["temp"] - 273.15).toStringAsFixed(1) + "°C",
      "Ressenti ${(data["main"]["feels_like"] - 273.15).toStringAsFixed(1)} °C",
      Conditions["$code"].toString(),
      sunrise,
      sunset,
      "${(data["wind"]["speed"] * 3.6).toStringAsFixed(0)} km/h",
      data["weather"][0]["icon"],
    );

    for (int i = 0; i < dataForecast["cnt"]; i++) {
      int code = dataForecast["list"][i]["weather"][0]["id"];

      var inputFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
      var inputDate = inputFormat.parse(dataForecast["list"][i]["dt_txt"]);

      var hourFormat = DateFormat('HH:mm');
      var hour = hourFormat.format(inputDate);

      var time = hour;
      if (hour == '00:00') {
        var dayFormat = DateFormat('EEEE');
        var day = dayFormat.format(inputDate);
        var jour = Days[day];

        time = jour + " " + hour;
      }

      forecast.add(
        Forecast(
          time,
          (dataForecast["list"][i]["main"]["temp"] - 273.15)
                  .toStringAsFixed(0) +
              "°C",
          Conditions["$code"].toString(),
          dataForecast["list"][i]["weather"][0]["icon"],
        ),
      );
    }

    cb();
  }
}
