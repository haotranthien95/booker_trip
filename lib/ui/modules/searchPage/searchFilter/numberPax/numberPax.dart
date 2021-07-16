import 'package:flutter/material.dart';

class NumerPax extends StatefulWidget {
  const NumerPax({Key? key}) : super(key: key);

  @override
  _NumerPaxState createState() => _NumerPaxState();
}

class _NumerPaxState extends State<NumerPax> {
  int paxCount = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
      ),
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 3),
            alignment: AlignmentDirectional.centerStart,
            child: Text("Số lượng vé trống",
                style: TextStyle(color: Colors.grey[400])),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white12, width: 1)),
            child: Row(
              children: [
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.blue),
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        shape: CircleBorder()),
                    onPressed: () {
                      if (paxCount > 1) {
                        setState(() {
                          paxCount--;
                        });
                      }
                    },
                    child: Icon(Icons.remove)),
                Container(
                    width: 25,
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      paxCount.toString(),
                      textScaleFactor: 1.3,
                    )),
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.blue),
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        shape: CircleBorder()),
                    onPressed: () {
                      if (paxCount < 99) {
                        setState(() {
                          paxCount++;
                        });
                      }
                    },
                    child: Icon(Icons.add)),
                Expanded(
                    child: Container(
                        alignment: AlignmentDirectional.center,
                        child: Text("Người lớn/Trẻ em",
                            style: TextStyle(
                                fontSize: 17, color: Colors.grey[400]))))
              ],
            ),
          )
        ],
      ),
    );
  }
}
