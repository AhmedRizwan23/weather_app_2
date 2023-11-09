import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:weather_app_2/Weatherpage.dart';

import 'package:weather_app_2/theme/theme_provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => Themeprovider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        home: const Weatherpage(),
        theme: Provider.of<Themeprovider>(context).themedata);
  }
}
