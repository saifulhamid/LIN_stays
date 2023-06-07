import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lin_stays/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
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
      // routes: {
      //   'home': (context)=> MyHomePage(),
      //   'wishlist': (context)=> WishList(),
      //   'bookings': (context)=> BookingPage(),
      //   'settings': (context)=> SettingsPage(),
      // },
    );
  }
}
