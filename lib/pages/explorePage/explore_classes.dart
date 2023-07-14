import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:lin_stays/database/functions/dbfunction.dart';
import 'package:lin_stays/database/functions/wishlistdb.dart';
import 'package:lin_stays/database/model/model.dart';

//EXPLORE PAGE
// ============= for making list view of resorts in explore page=============
// ignore: must_be_immutable
class Classes extends StatefulWidget {
  late Uint8List images;
  late int index;
  Classes({super.key, required this.images, required this.index});

  @override
  State<Classes> createState() => _ClassesState();
}

class _ClassesState extends State<Classes> {
  TextEditingController wishListName = TextEditingController();

  late LINModel _linModel;

  @override
  Widget build(BuildContext context) {
    final data = resortDetailList.value;
    _linModel = data[widget.index];
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Stack(
            children: [
              Container(
                width: 320,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: MemoryImage(widget.images), fit: BoxFit.fitWidth),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            _linModel.isFavorite = !_linModel.isFavorite!;
                            onClickStar();
                          });
                        },
                        icon: _linModel.isFavorite!
                            ? Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                            : Icon(
                                Icons.favorite,
                                color: Colors.white,
                              ))),
              )
            ],
          ),
          const SizedBox(
            height: 7,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 5,
            ),
            child: Text(
              _linModel.name,
              style: const TextStyle(
                  fontSize: 23, fontWeight: FontWeight.w500, letterSpacing: 2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              _linModel.place,
              style: const TextStyle(fontSize: 17),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              '₹${_linModel.price} per night',
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87),
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  Future<void> onClickStar() async {
    final data = LINModel(
        id: _linModel.id,
        name: _linModel.name,
        type: _linModel.type,
        noOfRooms: _linModel.noOfRooms,
        maximumGuest: _linModel.maximumGuest,
        price: _linModel.price,
        cleaningFee: _linModel.cleaningFee,
        receptionService: _linModel.receptionService,
        miscellaneous: _linModel.miscellaneous,
        rules: _linModel.rules,
        image: _linModel.image,
        place: _linModel.place,
        isFavorite: _linModel.isFavorite);

    print(data.isFavorite);
    print(data.id);

    if (data.isFavorite!) {
      setFavoriteStatus(data.id!, true);
    } else {
      print(data.id);
      // final wishlistData = Hive.openBox<LINModel>(dbWishlist);
      setFavoriteStatus(data.id!, false);
    }
  }
}
