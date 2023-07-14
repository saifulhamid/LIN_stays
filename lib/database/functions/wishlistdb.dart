import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lin_stays/database/model/model.dart';

ValueNotifier<List<LINModel>> resortWishList = ValueNotifier([]);

String dbWishlist = 'resortsDB';

Future<void> addToWishlist(LINModel value) async {
  final wishListDB = await Hive.openBox<LINModel>(dbWishlist);
  final id = await wishListDB.add(value);
  final data = wishListDB.get(id);
  await wishListDB.put(
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
          isFavorite: false));

  getAllWishlistItems();
  resortWishList.value.add(value);
  resortWishList.notifyListeners();
}

Future<void> getAllWishlistItems() async {
  final wishlistbDB = await Hive.openBox<LINModel>(dbWishlist);
  resortWishList.value.clear();

  resortWishList.value.addAll(wishlistbDB.values);
  resortWishList.notifyListeners();
}

void deleteWishlist(int id) async {
  final wishlistDetails = await Hive.openBox<LINModel>(dbWishlist);

  final LINModel? item = wishlistDetails.get(id);

  if (item != null) {
    item.isFavorite = false;

    await wishlistDetails.put(id, item);
  }

  await getAllWishlistItems();
}

Future<List<LINModel>> getFavoriteHotels() async {
  final wishlistDetails = await Hive.openBox<LINModel>(dbWishlist);
  final List<LINModel> favoriteHotels = [];
  for (var i = 0; i < wishlistDetails.length; i++) {
    final LINModel hotel = wishlistDetails.getAt(i) as LINModel;
    if (hotel.isFavorite!) {
      favoriteHotels.add(hotel);
    }
  }
  return favoriteHotels;
}

void setFavoriteStatus(int id, bool isFavorite) async {
  final wishlistDetails = await Hive.openBox<LINModel>(dbWishlist);

  final LINModel? hotel = wishlistDetails.get(id);
  if (hotel != null) {
    hotel.isFavorite = isFavorite;
    await wishlistDetails.put(id, hotel);
    
  }
}

