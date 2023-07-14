import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';

class Booked extends StatelessWidget {
  final image;
  final resortName;
  final rooms;
  final guest;
  final id;

  final price;
  const Booked(
      {super.key,
      this.image,
      this.resortName,
      this.rooms,
      this.guest,
      this.price,
      this.id});

  @override
  Widget build(BuildContext context) {
    String booked = 'Booked';
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: GestureDetector(
        onLongPress: () {},
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
                width: 150,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FullScreenWidget(
                    disposeLevel: DisposeLevel.Low,
                    child: Image.memory(
                      image,
                      height: 100,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        resortName,
                        style: TextStyle(fontSize: 20, letterSpacing: 1),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text('${rooms.toString()} rooms'),
                      Text('maximum ${guest.toString()} guests'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '₹$price',
                            style: TextStyle(fontSize: 18, letterSpacing: 1),
                          ),
                          Text(
                            booked,
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Cancelled extends StatelessWidget {
  final image;
  final resortName;
  final price;
  final rooms;
  final guests;
  final id;
  const Cancelled({
    super.key,
    this.image,
    this.resortName,
    this.rooms,
    this.guests,
    this.price,
    this.id,
  });

  @override
  Widget build(BuildContext context) {
    String cancelled = 'Cancelled';
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    resortName,
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text('${rooms.toString()} rooms'),
                  Text('${guests.toString()} guests'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        cancelled,
                        style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 255, 0, 0)),
                      ),
                      Text(
                        '₹$price',
                        style: TextStyle(
                            fontSize: 18,
                            decoration: TextDecoration.lineThrough,
                            decorationThickness: 2),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
