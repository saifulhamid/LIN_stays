// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: Image.asset(
          'assets/images/Logo.png',
          height: 40,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'About LIN Stays.',
                style: TextStyle(fontSize: 25),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                firstPara,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                secondPara,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                thirdPara,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                conclusion,
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String firstPara =
      'LIN Stays, short for Live In Nature Stays, is a resort booking app developed by Saiful Hamid A K. This app was created as a platform to learn UI design and explore the capabilities of the local database system called Hive. Please note that LIN Stays is purely an educational project and does not facilitate real resort bookings.';
  String secondPara =
      'At LIN Stays, our main objective is to provide users with a user-friendly interface and a seamless booking experience, showcasing the potential of Flutter for mobile application development. Through this project, Saiful Hamid A K aims to enhance his skills in UI design and gain hands-on experience with Hive as a local database solution.';
  String thirdPara =
      'While the LIN Stays app does not connect to real resorts for bookings, it offers a simulated environment where users can browse through various resort listings and explore the features of the app. This project serves as a stepping stone towards building more comprehensive and functional applications in the future.';
  String conclusion =
      'Thank you for your interest in LIN Stays, and we hope you enjoy exploring the app and its features.';
}
