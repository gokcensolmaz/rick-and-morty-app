import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rickandmorty_flutter/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

// TODO: GoRouter Implementation

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick And Morty',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0x004C4767)),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
