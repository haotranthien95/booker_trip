import 'package:flutter/material.dart';

class NumberSlot extends StatefulWidget {
  const NumberSlot(
      {Key? key,
      required this.onAdultChange,
      required this.onChildChange,
      this.paxCount = 1,
      this.childCount = 0})
      : super(key: key);

  final int paxCount;
  final int childCount;

  final Function(int) onAdultChange;
  final Function(int) onChildChange;

  @override
  _NumberSlotState createState() => _NumberSlotState();
}

class _NumberSlotState extends State<NumberSlot> {
  int paxCount = 1;
  int childCount = 0;
  @override
  void initState() {
    paxCount = widget.paxCount;
    childCount = widget.childCount;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
      ),
      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white12, width: 1)),
            child: Row(
              children: [
                Expanded(
                    child: Container(
                        alignment: AlignmentDirectional.bottomStart,
                        padding: EdgeInsets.only(left: 20),
                        child: Text("Người lớn/Trẻ em",
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey[400])))),
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        minimumSize: Size(30, 30),
                        side: BorderSide(color: Colors.blue),
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        shape: CircleBorder()),
                    onPressed: () {
                      if (paxCount > 0) {
                        setState(() {
                          paxCount--;
                          widget.onAdultChange(paxCount);
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
                        minimumSize: Size(30, 30),
                        side: BorderSide(color: Colors.blue),
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        shape: CircleBorder()),
                    onPressed: () {
                      if (paxCount < 99) {
                        setState(() {
                          paxCount++;
                          widget.onAdultChange(paxCount);
                        });
                      }
                    },
                    child: Icon(Icons.add)),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white12, width: 1)),
            child: Row(
              children: [
                Expanded(
                    child: Container(
                        alignment: AlignmentDirectional.bottomStart,
                        padding: EdgeInsets.only(left: 20),
                        child: Text("Dành riêng cho Trẻ em",
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey[400])))),
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        minimumSize: Size(30, 30),
                        fixedSize: Size(30, 30),
                        side: BorderSide(color: Colors.blue),
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        shape: CircleBorder()),
                    onPressed: () {
                      if (childCount > 0) {
                        setState(() {
                          childCount--;
                          widget.onChildChange(childCount);
                        });
                      }
                    },
                    child: Icon(Icons.remove)),
                Container(
                    width: 25,
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      childCount.toString(),
                      textScaleFactor: 1.3,
                    )),
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        minimumSize: Size(30, 30),
                        fixedSize: Size(30, 30),
                        side: BorderSide(color: Colors.blue),
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        shape: CircleBorder()),
                    onPressed: () {
                      if (childCount < 99) {
                        setState(() {
                          childCount++;
                          widget.onChildChange(childCount);
                        });
                      }
                    },
                    child: Icon(Icons.add)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
