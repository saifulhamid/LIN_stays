import 'package:hive/hive.dart';
part 'model.g.dart';

@HiveType(typeId: 0)
class LINModel {
  @HiveField(0)
  String name;
  @HiveField(1)
  String type;
  @HiveField(2)
  int noOfRooms;
  @HiveField(3)
  int maximumGuest;
  @HiveField(4)
  int price;
  @HiveField(5)
  int cleaningFee;
  @HiveField(6)
  String receptionService;
  @HiveField(7)
  List miscellaneous;
  @HiveField(8)
  List rules;
  @HiveField(9)
  int? id;
  @HiveField(10)
  String image;
  @HiveField(11)
  String place;
  @HiveField(12)
  bool? isFavorite = false;

  LINModel(
      {required this.name,
      required this.type,
      required this.noOfRooms,
      required this.maximumGuest,
      required this.price,
      required this.cleaningFee,
      required this.receptionService,
      required this.miscellaneous,
      required this.rules,
      this.id,
      required this.image,
      required this.place,
      this.isFavorite});
}

@HiveType(typeId: 1)
class BookAndCancel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String image;
  @HiveField(2)
  String name;
  @HiveField(3)
  String type;
  @HiveField(4)
  String place;
  @HiveField(5)
  int noOfRooms;
  @HiveField(6)
  int maximumGuests;
  @HiveField(7)
  int price;
  @HiveField(8)
  int cleaningFee;
  @HiveField(9)
  int startDay;
  @HiveField(10)
  int startMonth;
  @HiveField(11)
  int startYear;
  @HiveField(12)
  int endDay;
  @HiveField(13)
  int endMonth;
  @HiveField(14)
  int endYear;

  @HiveField(15)
  int daysRange;

  BookAndCancel(
      {this.id,
      required this.image,
      required this.name,
      required this.type,
      required this.place,
      required this.noOfRooms,
      required this.maximumGuests,
      required this.price,
      required this.cleaningFee,
      required this.startDay,
      required this.startMonth,
      required this.startYear,
      required this.endDay,
      required this.endMonth,
      required this.endYear,
      required this.daysRange
      });
}
