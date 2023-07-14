import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:lin_stays/database/functions/dbfunction.dart';
import 'package:lin_stays/database/model/model.dart';
import 'package:lin_stays/pages/explorePage/confirm_page.dart';


// ignore: must_be_immutable
class InDetail extends StatefulWidget {
  int index;
  InDetail(this.index, {super.key});

  @override
  State<InDetail> createState() => _InDetailState();
}

class _InDetailState extends State<InDetail> {

  String? resortPrice;

  late LINModel _linModel;
  @override
  void initState() {
    super.initState();
    final data = resortDetailList.value;
    _linModel = data[widget.index];
    resortPrice = _linModel.price.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SafeArea(
              child: ValueListenableBuilder(
            valueListenable: resortDetailList,
            builder: (BuildContext context, List<LINModel> resortDetails,
                Widget? child) {
              final data = resortDetails[widget.index];
              final List miscellaneousList = data.miscellaneous;
              final List rulesList = data.rules;
              final base64Image = data.image;
              final imageBytes = base64Decode(base64Image);

              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FullScreenWidget(
                        disposeLevel: DisposeLevel.Low,
                        child: Center(
                          child: ClipRRect(
                            child: Image.memory(
                              imageBytes,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${data.name.toUpperCase()}, ${data.place}',
                              style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 3),
                            ),
                            Text('${data.maximumGuest.toString()} guests'),
                            Text('${data.noOfRooms.toString()} rooms'),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      height: 40,
                      color: Color.fromARGB(153, 221, 221, 221),
                      indent: 18,
                      endIndent: 18,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Check-in/ check-out',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('check-in from: 12:00 PM'),
                          Text('check-in until 11:00 PM'),
                          Text('check-out until 11:00 PM'),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 40,
                      color: Color.fromARGB(153, 221, 221, 221),
                      indent: 18,
                      endIndent: 18,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'What this place offers',
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          miscellaneousList.isNotEmpty
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: miscellaneousList.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Text(miscellaneousList[index]),
                                    );
                                  },
                                )
                              : const Text(
                                  'No miscellaneous items available. Contact the owner for the details')
                        ],
                      ),
                    ),
                    const Divider(
                      height: 40,
                      color: Color.fromARGB(153, 221, 221, 221),
                      indent: 18,
                      endIndent: 18,
                    ),
                    // ----------------------------- House Rules
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'House Rules',
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          rulesList.isNotEmpty
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: rulesList.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Text(rulesList[index]),
                                    );
                                  },
                                )
                              : const Text(
                                  'Rules are as same as the every property. Contact the owner for more details'),
                          const Divider(
                            height: 40,
                            color: Color.fromARGB(153, 221, 221, 221),
                            indent: 18,
                            endIndent: 18,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    )
                  ]);
            },
          )),
        ),
        // ------------------------------------------------BottomAppBar --------------

        bottomSheet: BottomAppBar(
          surfaceTintColor: Colors.white,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '₹$resortPrice/-',
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w500),
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(Colors.green),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green.shade800),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)))),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ConfirmationPage(
                                    widget.index,
                                  )));
                    },
                    child: const Text(
                      'BOOK NOW',
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
          ),
        ));
  }
}
