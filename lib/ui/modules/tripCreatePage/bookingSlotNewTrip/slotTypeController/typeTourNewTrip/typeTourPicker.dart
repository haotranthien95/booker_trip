import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:new_ecom_project/ui/modules/tripCreatePage/bookingSlotNewTrip/slotTypeController/typeTourNewTrip/slotTypeList.dart';

class SlotTypePicker extends StatefulWidget {
  const SlotTypePicker(
      {Key? key, required this.onPicked, this.datalabel = "Chọn"})
      : super(key: key);
  final String datalabel;
  final Function(String) onPicked;
  @override
  _SlotTypePickerState createState() => _SlotTypePickerState();
}

class _SlotTypePickerState extends State<SlotTypePicker> {
  String _dataLabel = "Chọn";
  int _selectedValue = 0;
  final SlotTypeList typeList = SlotTypeList([
    'Lều',
    'Võng',
    'Phòng Khách Sạn',
    'HomeStay',
    'Bungalow',
  ]);
  @override
  void initState() {
    _dataLabel = widget.datalabel;
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
                  scrollController:
                      FixedExtentScrollController(initialItem: _selectedValue),
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
                      widget.onPicked(typeList.content[value]);
                    });
                  },
                ),
              ));
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
      ),
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(padding: EdgeInsets.zero),
        onPressed: () {
          _showPicker(context);
          print("Pick Tour Type Press");
        },
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 3, 0, 0),
          child: Row(
            children: [
              Center(
                  child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Center(
                  child: Text(
                    "Hình thức:",
                  ),
                ),
              )),
              Expanded(
                  flex: 5,
                  child: Container(
                    height: 40,
                    margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      _dataLabel,
                      textScaleFactor: 1,
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
    );
  }
}
