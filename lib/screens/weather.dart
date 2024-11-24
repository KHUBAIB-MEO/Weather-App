import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/utils/color_constants.dart';

class Weather extends StatefulWidget {
  const Weather({super.key});

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  TextEditingController searchCity = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: ColorConstants.bgNightColor,
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
                          // City search logic//
                          print(searchCity.text);
                        },
                        icon: const Icon(
                          Icons.check,
                          size: 30,
                        ))),
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            Container(
              width: 250,
              height: 250,
              color: ColorConstants.transparentColor,
              child:
                  Lottie.asset("assets/animation_widgets/sunny clear day.json"),
            ),
            const SizedBox(
              height: 70,
            ),
            Text(
              "Temperature \u00B0C",
              style:
                  TextStyle(color: ColorConstants.bgDefaultColor, fontSize: 30),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: 150,
              height: 30,
              color: ColorConstants.transparentColor,
              child: Center(
                child: Text(
                  "Feels Like 10\u00B0C",
                  style: TextStyle(
                      color: ColorConstants.bgDefaultColor, fontSize: 15),
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
                  "Wind speed 10 KM/H",
                  style: TextStyle(
                      color: ColorConstants.bgDefaultColor, fontSize: 15),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 150,
                  height: 30,
                  color: ColorConstants.transparentColor,
                  child: Center(
                    child: Text(
                      "SunRise 6.23 AM",
                      style: TextStyle(
                          color: ColorConstants.bgDefaultColor, fontSize: 15),
                    ),
                  ),
                ),
                Container(
                  width: 150,
                  height: 30,
                  color: ColorConstants.transparentColor,
                  child: Center(
                    child: Text(
                      "SunRise 6.23 PM",
                      style: TextStyle(
                          color: ColorConstants.bgDefaultColor, fontSize: 15),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
