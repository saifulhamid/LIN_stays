import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lin_stays/database/functions/dbfunction.dart';
import 'package:lin_stays/database/model/model.dart';
import 'package:lin_stays/homepage.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(LINModelAdapter().typeId)) {
    Hive.registerAdapter(LINModelAdapter());
  }
  if (!Hive.isAdapterRegistered(BookAndCancelAdapter().typeId)) {
    Hive.registerAdapter(BookAndCancelAdapter());
  }
  getAllDetails();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.green.shade700,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
      ),
      home: AnimatedSplashScreen(
        splash: Image.asset(
          'assets/images/SplashScreen.PNG',
          height: 90,
        ),
        splashTransition: SplashTransition.fadeTransition,
        duration: 2000,
        nextScreen: MyHomePage(),
      ),
    );
  }
}
