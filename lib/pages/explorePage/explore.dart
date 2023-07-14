import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lin_stays/database/functions/dbfunction.dart';
import 'package:lin_stays/database/model/model.dart';
import 'package:lin_stays/pages/explorePage/explore_classes.dart';
import 'package:lin_stays/pages/explorePage/indetail_page.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final searchController = TextEditingController();
  final fromController = TextEditingController();
  final toController = TextEditingController();
  var placeController = TextEditingController();

  List<LINModel> filteredLists = [];

  @override
  void initState() {
    super.initState();
    getAllDetails();
    filteredLists = resortDetailList.value;
  }

  void searchResort() {
    setState(() {
      filteredLists = resortDetailList.value
          .where((resort) =>
              resort.name
                  .toLowerCase()
                  .contains(searchController.text.toLowerCase()) ||
              resort.place
                  .toLowerCase()
                  .contains(searchController.text.toLowerCase()))
          .toList();
    });
  }

  void filterResort() {
    final fromPrice = int.tryParse(fromController.text);
    final toPrice = int.tryParse(toController.text);

    setState(() {
      if (fromPrice == null || toPrice == null) {
        filteredLists = resortDetailList.value.toList();
      } else {
        filteredLists = resortDetailList.value
            .where((resort) =>
                resort.place
                    .toLowerCase()
                    .contains(placeController.text.toLowerCase()) &&
                resort.price >= fromPrice &&
                resort.price <= toPrice)
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: Image.asset(
          'assets/images/Logo.png',
          height: 40,
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, bool isScrolled) {
              return [
                SliverAppBar(
                  backgroundColor: Colors.white,
                  title: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20))),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                children: [
                                  Icon(Icons.search),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: TextField(
                                      controller: searchController,
                                      onChanged: (_) => searchResort(),
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Where to?'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              filterIcon(context, fromController, toController,
                                  searchResort, placeController);
                            },
                            icon: const Icon(Icons.filter_list_outlined))
                      ],
                    ),
                  ),
                )
              ];
            },
            body: ValueListenableBuilder(
              valueListenable: resortDetailList,
              builder: (BuildContext context, List<LINModel> resortLists,
                  Widget? child) {
                return Container(
                  color: Colors.white,
                  child: ListView.builder(
                    itemCount: filteredLists.length,
                    itemBuilder: (ctx, index) {
                      final data = filteredLists[index];
                      final base64Image = data.image;
                      final imageBytes = base64Decode(base64Image);
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InDetail(index),
                              ));
                        },
                        child: Classes(
                          images: imageBytes,
                          index: index,
                        ),
                      );
                    },
                  ),
                );
              },
            )),
      ),
    );
  }

  filterIcon(
      BuildContext context,
      TextEditingController fromController,
      TextEditingController toController,
      Function searchResort,
      TextEditingController placeController) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 30,
                ),
                const Text(
                  'Let us know your budget',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: TextFormField(
                          controller: fromController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(3)),
                            labelText: 'From',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: TextFormField(
                          controller: toController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(3)),
                            labelText: 'To',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 40,
                  child: TextFormField(
                    controller: placeController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Place'),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 35,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        overlayColor:
                            MaterialStatePropertyAll(Colors.green.shade100),
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.green.shade500),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
                    onPressed: () {
                      filterResort();
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Apply',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
