import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:lin_stays/pages/bookings.dart';
import 'package:lin_stays/pages/explore.dart';
import 'package:lin_stays/pages/settings/settings.dart';
import 'package:lin_stays/pages/wishlists.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final screens = [ExplorePage(), WishList(), BookingPage(), SettingsPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Image.asset(
            'assets/images/Logo.png',
            height: 40,
          ),
          centerTitle: true,
        ),
        body: 
        screens[_currentIndex],
        bottomNavigationBar: GNav(
          gap: 10,
          onTabChange: (value) {
            setState(() {
              _currentIndex = value;
            });
          },
          tabs: [
            GButton(
              icon: Icons.home_outlined,
              iconActiveColor: Colors.green.shade900,
              text: 'Home',
              textColor: Colors.green.shade900,
            ),
            GButton(
              icon: Icons.favorite_border_rounded,
              iconActiveColor: Colors.green.shade900,
              text: 'Wishlists',
              textColor: Colors.green.shade900,
            ),
            GButton(
              icon: Icons.book_outlined,
              iconActiveColor: Colors.green.shade900,
              text: 'Bookings',
              textColor: Colors.green.shade900,
            ),
            GButton(
              icon: Icons.settings_outlined,
              iconActiveColor: Colors.green.shade900,
              text: 'Settings',
              textColor: Colors.green.shade900,
            ),
          ],
        ));
  }
}
