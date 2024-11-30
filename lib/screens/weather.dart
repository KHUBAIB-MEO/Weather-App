//import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/utils/color_constants.dart';
import 'package:http/http.dart' as http;

class Weather extends StatefulWidget {
  const Weather({super.key});

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  // ignore: prefer_typing_uninitialized_variables
  var weatherData;
  double temp = 0;
  int tempInt = 0;
  String? description;
  double feelsLike = 0;
  int feelsLikeInt = 0;
  double windSpeed = 0;
  int windSpeedInt = 0;
  String cityName = " ";
  String? bgColor;
  String imageShow = "";
  int? weatherId;
  int statusCode = 0;

  void imagePicker(int id, String backgroundColor) {
    if (id == 200 || id == 211 || id == 232) {
      imageShow = "assets/animation_widgets/thunderstorm.json";
    } else if (id == 300 ||
        id == 310 ||
        id == 321 ||
        id == 500 ||
        id == 503 ||
        id == 531) {
      imageShow = "assets/animation_widgets/rain.json";
    } else if (id == 800 && backgroundColor == "d") {
      imageShow = "assets/animation_widgets/sunny clear day.json";
    } else if (id == 801 || id == 804 || id == 803) {
      imageShow = "assets/animation_widgets/cloudy.json";
    } else if (id == 701 || id == 711 || id == 741 || id == 721) {
      imageShow = "assets/animation_widgets/fog.json";
    } else if (id == 800 && backgroundColor == "n") {
      imageShow = "assets/animation_widgets/night clear.json";
    }
  }

  void getWeatherData(String city) async {
    String baseUrl =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=675556f33d7e1777e499f101eaf8310e";
    Uri url = Uri.parse(baseUrl);
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        statusCode = response.statusCode;
        weatherData = json.decode(response.body);
        temp = weatherData["main"]["temp"] - 273.15;
        tempInt = temp.toInt();
        description = weatherData["weather"][0]["description"];
        feelsLike = weatherData["main"]["feels_like"] - 273.15;
        feelsLikeInt = feelsLike.toInt();
        windSpeed = (weatherData["wind"]["speed"]) * 3.6;
        windSpeedInt = windSpeed.toInt();
        cityName = weatherData["name"];
        bgColor = weatherData["weather"][0]["icon"];
        bgColor = bgColor![2];
        weatherId = weatherData["weather"][0]["id"];
        imagePicker(weatherId!, bgColor!);
      });
    } else {
      setState(() {
        bgColor = null;
        statusCode = response.statusCode;
      });
    }
  }

  TextEditingController searchCity = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: bgColor == null
            ? ColorConstants.bgDefaultColor
            : bgColor == "d"
                ? ColorConstants.bgDayColor
                : bgColor == "n"
                    ? ColorConstants.bgNightColor
                    : ColorConstants.bgDefaultColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 70,
              ),
              SizedBox(
                height: 50,
                width: 350,
                child: TextField(
                  controller: searchCity,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: ColorConstants.bgDefaultColor,
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        size: 30,
                      ),
                      hintText: "Enter City",
                      suffixIcon: IconButton(
                          onPressed: () {
                            String trimmedControllerText =
                                searchCity.text.trim();
                            getWeatherData(trimmedControllerText);
                            //setState(() {});
                          },
                          icon: const Icon(
                            Icons.check,
                            size: 30,
                          ))),
                ),
              ),
              statusCode != 200
                  ? Column(
                      children: [
                        const SizedBox(
                          height: 150,
                        ),
                        Text(
                          "No City Found",
                          style: TextStyle(
                              color: ColorConstants.bgNightColor, fontSize: 30),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        const SizedBox(
                          height: 70,
                        ),
                        Text(
                          cityName,
                          style: TextStyle(
                              color: ColorConstants.bgDefaultColor,
                              fontSize: 30),
                        ),
                        Container(
                          width: 250,
                          height: 250,
                          color: ColorConstants.transparentColor,
                          child: imageShow == ""
                              ? const Text("")
                              : Lottie.asset(imageShow),
                        ),
                        const SizedBox(
                          height: 70,
                        ),
                        Text(
                          " $tempInt \u00B0C",
                          style: TextStyle(
                              color: ColorConstants.bgDefaultColor,
                              fontSize: 30),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          description ?? "",
                          style: TextStyle(
                              color: ColorConstants.bgDefaultColor,
                              fontSize: 20),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Container(
                          width: 150,
                          height: 30,
                          color: ColorConstants.transparentColor,
                          child: Center(
                            child: Text(
                              "Feels Like $feelsLikeInt \u00B0C",
                              style: TextStyle(
                                  color: ColorConstants.bgDefaultColor,
                                  fontSize: 15),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 150,
                          height: 30,
                          color: ColorConstants.transparentColor,
                          child: Center(
                            child: Text(
                              "Wind Speed $windSpeedInt KM/H",
                              style: TextStyle(
                                  color: ColorConstants.bgDefaultColor,
                                  fontSize: 15),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
