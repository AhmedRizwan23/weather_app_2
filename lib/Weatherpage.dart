import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_2/models/weather_model.dart';
import 'package:weather_app_2/service/weaather_service.dart';
import 'package:weather_app_2/theme/theme.dart';
import 'package:weather_app_2/theme/theme_provider.dart';

class Weatherpage extends StatefulWidget {
  const Weatherpage({super.key});

  @override
  State<Weatherpage> createState() => _WeatherpageState();
}

class _WeatherpageState extends State<Weatherpage> {
  final _weatherservice = weatherservice("1af5ffff4e3e1675f012193ef48083de");
  Weather? _weather;

  _fetchWeather() async {
    String cityname = await _weatherservice.getcurrentcity();
    try {
      final weather = await _weatherservice.getweather(cityname);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherCondition(String mainCondition) {
    switch (mainCondition) {
      case "Clouds":
      case "Mist":
      case "Smoke":
      case "Haze":
      case "Dust":
      case "Fog":
        return 'assets/cloudy.json';
      case 'Rain':
      case "Drizzle":
      case "Shower rain":
        return 'assets/rain.json';
      case "Thunderstorm":
        return "assets/thunderstorm.json";
      case "Clear":
        return "assets/sunny.json";
      default:
        return "assets/sunny.json";
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _weather?.cityname ?? "Loading City",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Lottie.asset(
              getWeatherCondition(_weather?.maincondition ?? "Loading"),
              height: 200, // Adjust animation size
            ),
            Text(
              "${_weather?.temprature.round()}°C",
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            Text(
              _weather?.maincondition ?? "Loading",
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(
              height: 30,
            ),
            Builder(
              builder: (context) {
                var value = Provider.of<Themeprovider>(context, listen: false);
                return IconButton(
                  onPressed: () {
                    value.toggleTheme();
                  },
                  icon: value.themedata == lightmode
                      ? const Icon(Icons.dark_mode_outlined)
                      : const Icon(Icons.dark_mode),
                  iconSize: 50,
                  tooltip: value.themedata == lightmode
                      ? 'Switch to Dark Mode'
                      : 'Switch to Light Mode',
                );
              },
            ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
