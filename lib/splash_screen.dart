import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:rickandmorty_flutter/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  Future<bool> isFirstOpen() async {
    return await IsFirstRun.isFirstRun();
  }

  @override
  State<SplashScreen> createState() => SplashScreenPage();

}

Future<void> splashScreen(BuildContext context) async {
  await Future.delayed(const Duration(seconds: 3), () {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => const MyHomePage(title: "Rick And Morty")),
    );
  });
}

class SplashScreenPage extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_){
      checkFirstRun();
      splashScreen(context);
    });
  }
  String welcomeText = "Welcome!";
  Future<void> checkFirstRun() async {
    bool isFirstRun = await widget.isFirstOpen();
    setState(() {
      if (isFirstRun) {
        welcomeText = "Welcome!";
      } else {
        welcomeText = "Hello!";
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Align(
              heightFactor: 3,
              child: Container(
                height: 200,
                width: 400,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('lib/assets/logo.jpg'),
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
             Text(
              welcomeText,
              style: const TextStyle(
                  fontSize: 30,
                  fontFamily: String.fromEnvironment("Avenir"),
                  fontWeight: FontWeight.w400),
            )
          ],
        ),
      ),
    );
  }
}
