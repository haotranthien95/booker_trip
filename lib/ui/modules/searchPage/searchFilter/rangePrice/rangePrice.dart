import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RangePrice extends StatefulWidget {
  const RangePrice({Key? key}) : super(key: key);

  @override
  _RangePriceState createState() => _RangePriceState();
}

class _RangePriceState extends State<RangePrice> {
  TextEditingController startPrice = TextEditingController();
  TextEditingController endPrice = TextEditingController();
  int selectPrice = 0;
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
            child:
                Text("Khoảng giá", style: TextStyle(color: Colors.grey[400])),
          ),
          Row(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  child: CupertinoTextField(
                    onChanged: (text) {
                      if (selectPrice != 0) {
                        setState(() {
                          selectPrice = 0;
                          print("Return");
                        });
                      }
                    },
                    controller: startPrice,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                    ],
                    style: TextStyle(color: Colors.grey[50]),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white24, width: 2)),
                  ),
                ),
              ),
              Container(
                width: 20,
                alignment: AlignmentDirectional.center,
                child: Text(
                  "-",
                  textScaleFactor: 1.5,
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  child: CupertinoTextField(
                    onChanged: (text) {
                      if (selectPrice != 0) {
                        setState(() {
                          selectPrice = 0;
                          print("Return");
                        });
                      }
                    },
                    controller: endPrice,
                    enableInteractiveSelection: false,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                    ],
                    style: TextStyle(color: Colors.grey[50]),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white24, width: 2)),
                  ),
                ),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        side: BorderSide(
                            color: selectPrice == 1
                                ? Colors.deepOrange
                                : Colors.white12,
                            width: 1)),
                    child: Text("0 - 1000K",
                        textScaleFactor: 0.8,
                        style: TextStyle(color: Colors.white70)),
                    onPressed: () {
                      setState(() {
                        startPrice.text = "0";
                        endPrice.text = "1000000";
                        selectPrice = 1;
                      });
                    },
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        side: BorderSide(
                            color: selectPrice == 2
                                ? Colors.deepOrange
                                : Colors.white12,
                            width: 1)),
                    child: Text(
                      "1000K - 2000K",
                      style: TextStyle(color: Colors.white70),
                      textScaleFactor: 0.8,
                    ),
                    onPressed: () {
                      setState(() {
                        startPrice.text = "1000000";
                        endPrice.text = "2000000";
                        selectPrice = 2;
                      });
                    },
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        side: BorderSide(
                            color: selectPrice == 3
                                ? Colors.deepOrange
                                : Colors.white12,
                            width: 1)),
                    child: Text(
                      "2000K - 5000K",
                      textScaleFactor: 0.8,
                      style: TextStyle(color: Colors.white70),
                    ),
                    onPressed: () {
                      setState(() {
                        startPrice.text = "2000000";
                        endPrice.text = "5000000";
                        selectPrice = 3;
                      });
                    },
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
