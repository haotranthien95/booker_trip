import 'dart:math';

import 'package:flutter/material.dart';

class CoverProfile extends StatefulWidget {
  const CoverProfile({Key? key}) : super(key: key);

  @override
  _CoverProfileState createState() => _CoverProfileState();
}

class _CoverProfileState extends State<CoverProfile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            color: Colors.black,
            height: 325,
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image:
                            AssetImage('lib/ui/assets/image_block/camp5.jpeg'),
                        fit: BoxFit.cover,
                      )),
                ),
                Positioned(
                  top: 175,
                  child: Container(
                    height: 150,
                    width: 150,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 10, color: Colors.black),
                        image: DecorationImage(
                            image: AssetImage(
                                'lib/ui/assets/image_block/camp1.jpeg'),
                            fit: BoxFit.cover)),
                  ),
                ),
                Positioned(
                    bottom: 80,
                    right: 0,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(40, 40),
                        primary: Colors.grey[900],
                        shape: CircleBorder(
                            side: BorderSide(
                          color: Colors.black,
                        )),
                      ),
                      onPressed: () => print("Change cover pressed!!!"),
                      child: Icon(
                        Icons.photo_camera,
                        size: 20,
                        color: Colors.white,
                      ),
                    )),
                Positioned(
                    bottom: 75 - 5 - (130 * sqrt(2) / 4) - 17.5,
                    right: MediaQuery.of(context).size.width / 2 -
                        25 -
                        17.5 -
                        (130 * sqrt(2) / 4),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(40, 40),
                        primary: Colors.grey[900],
                        shape: CircleBorder(
                            side: BorderSide(
                          color: Colors.black,
                        )),
                      ),
                      onPressed: () => print("Change profile pressed!!!"),
                      child: Icon(
                        Icons.photo_camera,
                        size: 20,
                        color: Colors.white,
                      ),
                    ))
              ],
            ),
          ),
          Container(
              child: Text(
            "Lebron James",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
          ))
        ],
      ),
    );
  }
}
