import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lin_stays/database/functions/dbfunction.dart';
import 'package:lin_stays/database/model/model.dart';
import 'package:lin_stays/pages/settings/admin/admin_page.dart';
import 'package:lin_stays/pages/settings/admin/edit_resort.dart';
import 'package:lin_stays/pages/settings/admin/indetailsadminview.dart';

class adminEdit extends StatelessWidget {
  const adminEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: ValueListenableBuilder(
        valueListenable: resortDetailList,
        builder: (BuildContext ctx, List<LINModel> resortLists, Widget? child) {
          return Container(
            color: Colors.white,
            child: ListView.builder(
              itemCount: resortLists.length,
              itemBuilder: (BuildContext context, int index) {
                final data = resortLists[index];
                final base64Image = data.image;
                final imageBytes = base64Decode(base64Image);
                return GestureDetector(
                  onDoubleTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: Container(
                            height: 150,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextButton.icon(
                                  style: const ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.white)),
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EditResort(index)));
                                    // Navigator.of(context).pop();
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.black,
                                  ),
                                  label: const Text(
                                    'Edit',
                                    style: TextStyle(color: (Colors.black)),
                                  ),
                                ),
                                TextButton.icon(
                                  onPressed: () {
                                    deleteDetails(data.id!);
                                    Navigator.of(context).pop();
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  label: const Text(
                                    'Delete',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => InDetailAdminView(index)));
                  },
                  child: ListTile(
                    leading:
                        SizedBox(width: 80, child: Image.memory(imageBytes)),
                    title: Text(data.name),
                    trailing: Text('₹${data.price.toString()}.00'),
                    subtitle: Text(data.place.toLowerCase()),
                  ),
                );
              },
            ),
          );
        },
      )),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          hoverColor: Colors.white,
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => AdminPage(),
                ));
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          )),
    );
  }
}
