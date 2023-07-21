
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rickandmorty_flutter/providers/api_provider.dart';
import 'package:rickandmorty_flutter/screens/home_screen.dart';
import 'package:rickandmorty_flutter/screens/splash_screen.dart';

// TODO: LazyLoading eklemek
// TODO: Arama eklemek / filtre
// TODO: Kart yapısını düzenlemek
// TODO: Karakter detay sayfası



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ApiProvider()),
        // Provide the ApiProvider
      ],
      child: MaterialApp(
        title: 'Rick And Morty',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0x004C4767)),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
