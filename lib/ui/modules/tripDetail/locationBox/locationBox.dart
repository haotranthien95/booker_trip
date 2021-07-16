import 'package:flutter/material.dart';

class LocationMapBox extends StatelessWidget {
  const LocationMapBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white12,
      //padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
      alignment: AlignmentDirectional.centerStart,
      margin: EdgeInsets.fromLTRB(0, 3, 0, 3),
      child: Column(
        children: [
          Container(
            child: Image.asset(
              'lib/ui/assets/map/map1.png',
              height: 250,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: Row(
              children: [
                Container(
                  child: Icon(
                    Icons.location_pin,
                    size: 20,
                    color: Colors.orange,
                  ),
                  alignment: Alignment.centerLeft,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: Text(
                      "Đa Mi, Tánh Linh, Bình Thuận . 25km from Phan Thiet.",
                      maxLines: 5,
                      style: TextStyle(),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
