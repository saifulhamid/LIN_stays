import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:lin_stays/database/functions/bookingdb.dart';
import 'package:lin_stays/database/functions/dbfunction.dart';
import 'package:lin_stays/database/model/model.dart';
import '../../homepage.dart';

class ConfirmationPage extends StatefulWidget {
  final index;
  const ConfirmationPage(this.index, {super.key});

  @override
  State<ConfirmationPage> createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  late LINModel _linModel;

  late DateTime start;
  late DateTime end;

  @override
  void initState() {
    super.initState();
    final data = resortDetailList.value;
    _linModel = data[widget.index];
    start = DateTime.now();
    end = start.add(const Duration(days: 1));
  }

  _ConfirmationPageState();

  DateTimeRange dateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now().add(const Duration(days: 1)),
  );
  Future datePicker() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(2024),
        initialDateRange: dateRange);
    if (newDateRange == null) return;
    setState(() => dateRange = newDateRange);
  }

  @override
  Widget build(BuildContext context) {
    final start = dateRange.start;
    final end = dateRange.end;
    final range = dateRange.duration;
    final bytes = _linModel.image;
    final image = base64Decode(bytes);
    final totalPayable = _linModel.price * range.inDays + _linModel.cleaningFee;
    final totalPerDay = _linModel.price * range.inDays;

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: const Text('Confirmation'),
        centerTitle: true,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Container(
                decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(width: 1))),
              ),
            )),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                            _linModel.name,
                            style: const TextStyle(fontSize: 22),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(_linModel.type.toString()),
                          Text('${_linModel.noOfRooms.toString()} rooms'),
                          Text(
                              '${_linModel.maximumGuest.toString()} guests maximum'),
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
                    'Your Trip:',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Dates:',
                        style: TextStyle(fontSize: 16),
                      ),
                      IconButton(
                          onPressed: () {
                            datePicker();
                          },
                          icon: const Icon(
                            Icons.calendar_month_outlined,
                            color: Colors.blueAccent,
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        '${start.day}/${start.month}/${start.year}',
                        style: const TextStyle(
                            letterSpacing: 1,
                            fontWeight: FontWeight.w500,
                            fontSize: 17),
                      ),
                      const SizedBox(width: 5),
                      const Text('-'),
                      const SizedBox(width: 5),
                      Text('${end.day}/${end.month}/${end.year}',
                          style: const TextStyle(
                              letterSpacing: 1,
                              fontWeight: FontWeight.w500,
                              fontSize: 17)),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text('${range.inDays} Days',
                      style: const TextStyle(
                          letterSpacing: 1,
                          fontWeight: FontWeight.w500,
                          fontSize: 17)),
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
                        '₹${_linModel.price.toString()} × ${range.inDays} days',
                        style: const TextStyle(letterSpacing: 1),
                      ),
                      Text(
                        '₹$totalPerDay',
                        style: const TextStyle(fontSize: 17, letterSpacing: 2),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Cleaning fee',
                        style: TextStyle(letterSpacing: 1),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            border: Border(
                          bottom: BorderSide(
                              width: 1,
                              color: Color.fromARGB(255, 202, 202, 202)),
                        )),
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          '₹${_linModel.cleaningFee.toString()}',
                          style:
                              const TextStyle(fontSize: 17, letterSpacing: 2),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total Payable',
                        style: TextStyle(fontSize: 17, letterSpacing: 1),
                      ),
                      Text(
                        '₹$totalPayable',
                        style: const TextStyle(
                            fontSize: 20,
                            letterSpacing: 2,
                            fontWeight: FontWeight.w500),
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => MyHomePage()),
                        (route) => false);
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
                ElevatedButton(
                  onPressed: () {
                    onClickConfirm(range.inDays);
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 11, 129, 1)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                      overlayColor: MaterialStateProperty.all(Colors.green)),
                  child: const Text(
                    'Confirm Booking',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }

  onClickConfirm(int range) {
    final name = _linModel.name;
    final type = _linModel.type;
    final noOfRooms = _linModel.noOfRooms;
    final guests = _linModel.maximumGuest;
    final price = _linModel.price;
    final cleaningFee = _linModel.cleaningFee;
    final image = _linModel.image;
    final place = _linModel.place;
    final startDay = start.day;
    final startMonth = start.month;
    final startYear = start.year;
    final endDay = end.day;
    final endMonth = end.month;
    final endYear = end.year;
    final daysRange = range;

    final book = BookAndCancel(
        name: name,
        type: type,
        noOfRooms: noOfRooms,
        price: price,
        cleaningFee: cleaningFee,
        maximumGuests: guests,
        image: image,
        place: place,
        startDay: startDay,
        startMonth: startMonth,
        startYear: startYear,
        endDay: endDay,
        endMonth: endMonth,
        endYear: endYear,
        daysRange: daysRange);
    bookResort(book);
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(),
        ),
        (route) => false);
  }
}
