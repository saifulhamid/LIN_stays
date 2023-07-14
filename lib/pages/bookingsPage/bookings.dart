import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lin_stays/database/functions/bookingdb.dart';
import 'package:lin_stays/database/model/model.dart';
import 'package:lin_stays/homepage.dart';
import 'package:lin_stays/pages/bookingsPage/details_in_bookings.dart';
import 'booking_classes.dart';

class BookingPage extends StatefulWidget {
  BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  late LINModel linmodel;

  @override
  Widget build(BuildContext context) {
    getAllBooked();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                    (route) => false);
              },
              child: Image.asset(
                'assets/images/Logo.png',
                height: 40,
              ),
            ),
            centerTitle: true,
            bottom: const TabBar(
              tabs: [
                Tab(
                  child: Text(
                    'Booked',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Tab(
                  child: Text(
                    'Cancelled',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: Colors.black,
            ),
          ),
          body: TabBarView(children: [
            ValueListenableBuilder(
              valueListenable: bookedDetailsList,
              builder: (BuildContext context, List<BookAndCancel> bookedresort,
                  Widget? child) {
                if (bookedresort.isEmpty) {
                  return const Column(
                    children: [
                      SizedBox(
                        height: 230,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "'You haven't booked any resort'",
                            style: TextStyle(
                                fontSize: 17,
                                letterSpacing: 1.5,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  );
                } else {
                  return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: ListView.builder(
                        itemCount: bookedresort.length,
                        itemBuilder: (context, index) {
                          final data = bookedresort[index];
                          final base64 = data.image;
                          final image = base64Decode(base64);

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DetailsOfBooked(index: index),
                                  ));
                            },
                            child: Booked(
                              image: image,
                              resortName: data.name,
                              price: data.price.toString(),
                              rooms: data.noOfRooms,
                              guest: data.maximumGuests,
                              id: data.id,
                            ),
                          );
                        },
                      ));
                }
              },
            ),
            ValueListenableBuilder(
              valueListenable: cancelledDetailsList,
              builder: (BuildContext context, List<BookAndCancel> bookedresort,
                  Widget? child) {
                return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: ListView.builder(
                      itemCount: bookedresort.length,
                      itemBuilder: (context, index) {
                        final data = bookedresort[index];
                        final base64 = data.image;
                        final image = base64Decode(base64);

                        return GestureDetector(
                          onDoubleTap: () => deleteCancelled(data.id!),
                          child: Cancelled(
                            image: image,
                            resortName: data.name,
                            price: data.price.toString(),
                            rooms: data.noOfRooms,
                            guests: data.maximumGuests,
                            id: data.id,
                          ),
                        );
                      },
                    ));
              },
            ),
          ])),
    );
  }
}
