// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lin_stays/database/model/model.dart';

ValueNotifier<List<LINModel>> resortDetailList = ValueNotifier([]);

String dbName = 'resortsDB';

Future<void> addDetails(LINModel value) async {
  final resortsDB = await Hive.openBox<LINModel>(dbName);
  final id = await resortsDB.add(value);
  final data = resortsDB.get(id);
  await resortsDB.put(
    id,
    LINModel(
      id: id,
      name: data!.name,
      type: data.type,
      place: data.place,
      noOfRooms: data.noOfRooms,
      maximumGuest: data.maximumGuest,
      price: data.price,
      cleaningFee: data.cleaningFee,
      receptionService: data.receptionService,
      miscellaneous: data.miscellaneous,
      rules: data.rules,
      image: data.image,
      isFavorite: false,
    ),
  );

  getAllDetails();
}

Future<void> getAllDetails() async {
  final resortDB = await Hive.openBox<LINModel>(dbName);
  resortDetailList.value.clear();

  resortDetailList.value.addAll(resortDB.values);
  resortDetailList.notifyListeners();
}

void deleteDetails(int id) async {
  final resortDetails = await Hive.openBox<LINModel>(dbName);
  await resortDetails.delete(id);
  getAllDetails();
}
