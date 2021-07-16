import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_ecom_project/ui/modules/searchPage/searchFilter/typeTour/travelTypeList.dart';
import 'package:new_ecom_project/core/modules/createTripFileHelp.dart';
import 'travelTypeList.dart';

class TypeTourPickerNewTrip extends StatefulWidget {
  const TypeTourPickerNewTrip({Key? key}) : super(key: key);

  @override
  _TypeTourPickerNewTripState createState() => _TypeTourPickerNewTripState();
}

class _TypeTourPickerNewTripState extends State<TypeTourPickerNewTrip> {
  String _dataLabel = tripController.tripType;
  int _selectedValue = 0;
  final TypeList typeList = TypeList([
    'Du lịch nghỉ dưỡng- Relax Travelling',
    'Cắm trại dã ngoại - Camping',
    'Đi bộ đường dài - Hiking',
    'Khám phá thiên nhiên - Trekking',
    'Sinh tồn nơi hoang dã - Survival',
  ]);
  @override
  void initState() {
    _dataLabel = tripController.tripType;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void _showPicker(BuildContext context) {
      showCupertinoModalPopup(
          context: context,
          builder: (_) => Container(
                height: 250,
                child: CupertinoPicker(
                  useMagnifier: true,
                  backgroundColor: Colors.black,
                  itemExtent: 30,
                  scrollController: FixedExtentScrollController(initialItem: 0),
                  children: [
                    Text(
                      typeList.content[0],
                      textAlign: TextAlign.left,
                    ),
                    Text(typeList.content[1]),
                    Text(typeList.content[2]),
                    Text(typeList.content[3]),
                    Text(typeList.content[4]),
                    // Text(typeList.content[5]),
                  ],
                  onSelectedItemChanged: (value) {
                    setState(() {
                      _selectedValue = value;
                      _dataLabel = typeList.content[value];
                    });
                    tripController.tripType = typeList.content[value];
                    print("Loai hinh: " + tripController.tripType);
                  },
                ),
              ));
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
      ),
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 3),
            alignment: AlignmentDirectional.centerStart,
            child: Text("Loại hình du lịch",
                style: TextStyle(color: Colors.grey[200], fontSize: 18)),
          ),
          OutlinedButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white))),
                padding: MaterialStateProperty.all(EdgeInsets.zero)),
            onPressed: () {
              _showPicker(context);
              print("Pick Tour Type Press");
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 3, 0, 0),
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.festival,
                        size: 25,
                        color: Colors.orange,
                      )),
                  Expanded(
                      flex: 6,
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          _dataLabel,
                          textScaleFactor: 1.1,
                          style: TextStyle(color: Colors.grey[50]),
                        ),
                      )),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                      color: Colors.orange,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
