import 'package:flutter/material.dart';
import 'package:alarmo/features/home/home_page.dart';
import 'package:alarmo/features/onboarding/onboarding_page.dart';
import 'package:alarmo/features/location/location_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alarmo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const OnboardingPage(),
      routes: {
        '/location': (context) => const LocationPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}