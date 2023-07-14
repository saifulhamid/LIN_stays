import 'package:flutter/material.dart';

class TermsOfUse extends StatelessWidget {
  TermsOfUse({super.key});

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
                'Welcome to LIN Stays!',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                introduction,
                style: const TextStyle(fontSize: 17),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'App Description:',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                appDescription,
                style: const TextStyle(fontSize: 17),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Admin Page:',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                adminPage,
                style: const TextStyle(fontSize: 17),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'User Experience:',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                userExperience,
                style: const TextStyle(fontSize: 17),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Booking And cancellation:',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                bookingAndCancellation,
                style: const TextStyle(fontSize: 17),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Terms of Use:',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                termsOfUseOfTheApp,
                style: const TextStyle(fontSize: 17),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                conclution,
                style: const TextStyle(fontSize: 17),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String introduction =
      'LIN Stays is an innovative resort booking app developed by Saiful Hamid A K, utilizing the power of Hive, a local database solution. Our app is specifically designed to enhance your understanding of UI design while exploring the functionalities of Hive. Please note that LIN Stays is a simulation app and does not facilitate real resort bookings.';
  String appDescription =
      'The Resort Booking App offers a platform for users to learn and explore UI design principles and Hive functionalities. Through this app, users can familiarize themselves with the process of booking and managing resort reservations, all within a simulated environment.';
  String adminPage =
      'As part of our comprehensive features, LIN Stays includes an exclusive Admin Page accessible through the key "1234". Once logged in, administrators gain privileged access to manage resort details. You can effortlessly add new resorts, providing essential information such as names, locations, amenities, and captivating images. Moreover, administrators have full control to edit or delete resort details as necessary.';
  String userExperience =
      'On the user side of the app, users can view the added resort details, including resort names, locations, and available amenities. By clicking on a specific resort, users can access detailed information about the resort, such as descriptions, pricing, and additional images. Users have the option to book any available resort.';
  String bookingAndCancellation =
      'The Bookings section allows users to view their booked resorts, providing a convenient way to keep track of upcoming reservations. After booking a resort, users can access the booking details, including reservation dates, resort information, and pricing. If necessary, users also have the option to cancel their bookings.';
  String termsOfUseOfTheApp =
      'LIN Stays is a simulated resort booking app designed for educational purposes only. All resort details, bookings, and cancellations made within the app are strictly for learning and demonstration purposes. Please refrain from using the app for actual resort bookings.';
  String conclution =
      'Enjoy exploring the UI design and Hive functionalities with the Resort Booking App!';
}
