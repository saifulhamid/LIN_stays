import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lin_stays/database/functions/wishlistdb.dart';
import 'package:lin_stays/database/model/model.dart';

class WishList extends StatefulWidget {
  const WishList({super.key});

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  ValueNotifier<List<LINModel>> favoriteHotels = ValueNotifier([]);
  @override
  void initState() {
    super.initState();
    initializeFavoriteHotels();
  }

  Future<void> initializeFavoriteHotels() async {
    List<LINModel> hotels = await getFavoriteHotels();
    favoriteHotels.value = hotels;
  }

  @override
  Widget build(BuildContext context) {
    getAllWishlistItems();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset(
          'assets/images/Logo.png',
          height: 40,
        ),
        centerTitle: true,
        surfaceTintColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          // color: Colors.amber,
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 30),
                child: Text(
                  'Wishlists',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ValueListenableBuilder(
                valueListenable: favoriteHotels,
                builder: (context, List<LINModel> wishlist, child) {
                  if (wishlist.isEmpty) {
                    return const Column(
                      children: [
                        SizedBox(
                          height: 200,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "'Your wishlist is waiting to be filled.\nExplore and save your dream items.'",
                              style: TextStyle(
                                  fontSize: 17,
                                  letterSpacing: 1.5,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    );
                  } else {
                    return Expanded(
                      child: Container(
                        child: ListView.builder(
                          itemCount: wishlist.length,
                          itemBuilder: (context, index) {
                            final data = wishlist[index];
                            final base64 = data.image;
                            final image = base64Decode(base64);
                            return ListTile(
                              leading: SizedBox(
                                width: 80,
                                child: Image.memory(image),
                              ),
                              title: Text(data.name,
                                  style: const TextStyle(letterSpacing: 1)),
                              subtitle: Text(
                                '₹${data.price.toString()}',
                                style: const TextStyle(letterSpacing: 1),
                              ),
                              trailing: IconButton(
                                  onPressed: () {
                                    setFavoriteStatus(data.id!, false);
                                    initializeFavoriteHotels();
                                  },
                                  icon: const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                    size: 20,
                                  )),
                            );
                          },
                        ),
                      ),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
