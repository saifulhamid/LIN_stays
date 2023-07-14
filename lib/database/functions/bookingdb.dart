
// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lin_stays/database/model/model.dart';

ValueNotifier<List<BookAndCancel>> bookedDetailsList =
    ValueNotifier<List<BookAndCancel>>([]);
ValueNotifier<List<BookAndCancel>> cancelledDetailsList =
    ValueNotifier<List<BookAndCancel>>([]);

String resortBooked = 'resortBooked';
String resortCancelled = 'resortCancelled';

Future<void> bookResort(BookAndCancel value) async {
  final bookeddb = await Hive.openBox<BookAndCancel>(resortBooked);
  final id = await bookeddb.add(value);
  final data = bookeddb.get(id);
  await bookeddb.put(
      id,
      BookAndCancel(
          id: id,
          image: data!.image,
          name: data.name,
          type: data.type,
          place: data.place,
          noOfRooms: data.noOfRooms,
          maximumGuests: data.maximumGuests,
          price: data.price,
          cleaningFee: data.cleaningFee,
          startDay: data.startDay,
          startMonth: data.startMonth,
          startYear: data.startYear,
          endDay: data.endDay,
          endMonth: data.endMonth,
          endYear: data.endYear,
          daysRange: data.daysRange));
}

Future<void> getAllBooked() async {
  final bookeddb = await Hive.openBox<BookAndCancel>(resortBooked);
  final cancelleddb = await Hive.openBox<BookAndCancel>(resortCancelled);
  bookedDetailsList.value.clear();
  cancelledDetailsList.value.clear();

  bookedDetailsList.value.addAll(bookeddb.values);
  cancelledDetailsList.value.addAll(cancelleddb.values);
  bookedDetailsList.notifyListeners();
  cancelledDetailsList.notifyListeners();
}

void cancelBooked(int id) async {
  final cancelled = await Hive.openBox<BookAndCancel>(resortBooked);
  await cancelled.delete(id);
  getAllBooked();
}

Future<void> cancelledResort(BookAndCancel value) async {
  final bookeddb = await Hive.openBox<BookAndCancel>(resortCancelled);
  final id = await bookeddb.add(value);
  final data = bookeddb.get(id);
  await bookeddb.put(
      id,
      BookAndCancel(
          id: id,
          image: data!.image,
          name: data.name,
          type: data.type,
          place: data.place,
          noOfRooms: data.noOfRooms,
          maximumGuests: data.maximumGuests,
          price: data.price,
          cleaningFee: data.cleaningFee,
          startDay: data.startDay,
          startMonth: data.startMonth,
          startYear: data.startYear,
          endDay: data.endDay,
          endMonth: data.endMonth,
          endYear: data.endYear,
          daysRange: data.daysRange));
}

void deleteCancelled(int id) async {
  final cancelled = await Hive.openBox<BookAndCancel>(resortCancelled);
  await cancelled.delete(id);
  getAllBooked();
}
