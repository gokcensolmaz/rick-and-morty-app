import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:rickandmorty_flutter/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  Future<bool> isFirstOpen() async {
    return await IsFirstRun.isFirstRun();
  }

  @override
  State<SplashScreen> createState() => SplashScreenPage();

}

Future<void> splashScreen(BuildContext context) async {
  await Future.delayed(const Duration(seconds: 5), () {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => HomeScreen()),
    );
  });
}

class SplashScreenPage extends State<SplashScreen> with TickerProviderStateMixin {
  late FlutterGifController controller = FlutterGifController(vsync: this);

  @override
  void initState() {
    controller.repeat(min: 0, max: 140, period: const Duration(milliseconds: 1250));
    super.initState();
   SchedulerBinding.instance.addPostFrameCallback((_) {
      checkFirstRun();
      splashScreen(context);
    });
  }
  @override
  void dispose() {
    controller.dispose(); // Dispose the controller to prevent Ticker leak
    super.dispose();
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
      backgroundColor: Color(0xFE4C4767),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 170,
              width: 700,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: AssetImage('lib/assets/logo.png'),
                ),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
             GifImage(
                  controller: controller,
                  image: AssetImage('lib/assets/portal-gun.gif')
              ),

             Text(
              welcomeText,
              style: const TextStyle(
                  fontSize: 40,
                  fontFamily: String.fromEnvironment("Avenir"),
                  fontWeight: FontWeight.w400,
              color: Color(0xFF93EC67)),
            )
          ],
        ),
      ),
    );
  }
}
