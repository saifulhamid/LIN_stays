import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:lin_stays/database/functions/bookingdb.dart';
import 'package:lin_stays/database/model/model.dart';
import 'package:lin_stays/homepage.dart';

class DetailsOfBooked extends StatefulWidget {
  final index;
  const DetailsOfBooked({super.key, this.index});

  @override
  State<DetailsOfBooked> createState() => _DetailsOfBookedState();
}

class _DetailsOfBookedState extends State<DetailsOfBooked> {
  late BookAndCancel _bookAndCancel;

  @override
  void initState() {
    super.initState();
    final data = bookedDetailsList.value;
    _bookAndCancel = data[widget.index];
  }

  _DetailsOfBookedState();
  @override
  Widget build(BuildContext context) {
    final base64 = _bookAndCancel.image;
    final image = base64Decode(base64);
    final resortTotal = _bookAndCancel.price * _bookAndCancel.daysRange;
    final totalPayable = resortTotal + _bookAndCancel.cleaningFee;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset(
          'assets/images/Logo.png',
          height: 40,
        ),
        centerTitle: true,
        bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
            )),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Row(
                children: [
                  SizedBox(
                    height: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: FullScreenWidget(
                        disposeLevel: DisposeLevel.Low,
                        child: Image.memory(
                          image,
                          height: 140,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _bookAndCancel.name,
                            style:
                                const TextStyle(fontSize: 20, letterSpacing: 1),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Text(
                            '${_bookAndCancel.place}',
                            style: const TextStyle(letterSpacing: 1),
                          ),
                          Text('${_bookAndCancel.noOfRooms.toString()} rooms',
                              style: const TextStyle(letterSpacing: 1)),
                          Text(
                              'maximum ${_bookAndCancel.maximumGuests.toString()} guests',
                              style: const TextStyle(letterSpacing: 1)),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Divider(
              thickness: 1,
              height: 50,
              color: Color.fromARGB(255, 235, 235, 235),
              endIndent: 25,
              indent: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Your Trip',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Dates:',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        '${_bookAndCancel.startDay}/${_bookAndCancel.startMonth}/${_bookAndCancel.startYear}',
                        style: const TextStyle(letterSpacing: 1, fontSize: 17),
                      ),
                      const SizedBox(width: 5),
                      const Text('-'),
                      const SizedBox(width: 5),
                      Text(
                        '${_bookAndCancel.endDay}/${_bookAndCancel.endMonth}/${_bookAndCancel.endYear}',
                        style: const TextStyle(letterSpacing: 1, fontSize: 17),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${_bookAndCancel.daysRange} day',
                    style: const TextStyle(letterSpacing: 1, fontSize: 16),
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 1,
              height: 50,
              color: Color.fromARGB(255, 235, 235, 235),
              endIndent: 25,
              indent: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Price details',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          '₹${_bookAndCancel.price} × ${_bookAndCancel.daysRange} day',
                          style: const TextStyle(letterSpacing: 1)),
                      Text(
                        '₹${resortTotal.toString()}',
                        style: const TextStyle(fontSize: 17, letterSpacing: 1),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Cleaning fee',
                          style: TextStyle(letterSpacing: 1)),
                      Container(
                        decoration: const BoxDecoration(
                            border: Border(
                          bottom: BorderSide(
                              width: 1,
                              color: Color.fromARGB(255, 202, 202, 202)),
                        )),
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          '₹${_bookAndCancel.cleaningFee.toString()}',
                          style:
                              const TextStyle(fontSize: 17, letterSpacing: 1),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total Payable',
                          style: TextStyle(letterSpacing: 1, fontSize: 17)),
                      Text(
                        '₹${totalPayable.toString()}',
                        style: const TextStyle(fontSize: 20, letterSpacing: 1),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 1,
              height: 50,
              color: Color.fromARGB(255, 235, 235, 235),
              endIndent: 25,
              indent: 25,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Payment',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Pay at the property'),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 1,
              height: 50,
              color: Color.fromARGB(255, 235, 235, 235),
              endIndent: 25,
              indent: 25,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cancellation Policy',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          'Free cancellation for 48 hours. Cancel in between last \n48 hours for partial refund.',
                          overflow: TextOverflow.fade),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 330,
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Cancellation'),
                              content: const Text(
                                  'Are you sure you want to cancel this booking?'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MyHomePage()),
                                          (route) => false);
                                    },
                                    child: const Text(
                                      'No',
                                      style: TextStyle(color: Colors.black),
                                    )),
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                            builder: (context) => MyHomePage(),
                                          ),
                                          (route) => false);
                                      onCancelResort();
                                      cancelBooked(_bookAndCancel.id!);
                                    },
                                    child: const Text(
                                      'Yes',
                                      style: TextStyle(color: Colors.red),
                                    )),
                              ],
                            );
                          });
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 183, 12, 0)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                        overlayColor: MaterialStateProperty.all(Colors.red)),
                    child: const Text(
                      'Cancel Booking',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }

  void onCancelResort() {
    final data = BookAndCancel(
      image: _bookAndCancel.image,
      name: _bookAndCancel.name,
      type: _bookAndCancel.type,
      place: _bookAndCancel.place,
      noOfRooms: _bookAndCancel.noOfRooms,
      maximumGuests: _bookAndCancel.maximumGuests,
      price: _bookAndCancel.price,
      cleaningFee: _bookAndCancel.cleaningFee,
      startDay: _bookAndCancel.startDay,
      startMonth: _bookAndCancel.startMonth,
      startYear: _bookAndCancel.startYear,
      endDay: _bookAndCancel.endDay,
      endMonth: _bookAndCancel.endMonth,
      endYear: _bookAndCancel.endYear,
      daysRange: _bookAndCancel.daysRange,
    );
    cancelledResort(data);
  }
}
