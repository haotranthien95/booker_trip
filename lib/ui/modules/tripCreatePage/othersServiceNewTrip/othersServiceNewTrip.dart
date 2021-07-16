import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_ecom_project/core/modules/createTripFileHelp.dart';

class OthersServiceNewTrip extends StatefulWidget {
  const OthersServiceNewTrip({Key? key}) : super(key: key);

  @override
  _OthersServiceNewTripState createState() => _OthersServiceNewTripState();
}

class _OthersServiceNewTripState extends State<OthersServiceNewTrip> {
  List<String> _serviceList = [
    "Đã bao gồm thuế phí",
    "Không cần thanh toán trước",
    "Miễn phí hủy vé",
    "Bao gồm bảo hiểm du lịch",
  ];
  List<String> _serviceListCustom = [];
  List<bool> _selectedList = [false, false, false, false];
  late TextEditingController _addServiceController;

  late FocusNode myFocusNode;

  @override
  void dispose() {
    myFocusNode.dispose();
    _addServiceController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    myFocusNode = FocusNode();
    _addServiceController = TextEditingController();
    getFromJsonData();
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    syncWithJsonData();
    print(tripController.serviceList.toString());
    super.setState(fn);
  }

  syncWithJsonData() {
    List<String> tempList = [];
    for (int i = 0; i < 4; i++) {
      if (_selectedList[i]) {
        tempList.add(_serviceList[i]);
      }
    }
    tempList.addAll(_serviceListCustom);
    tripController.serviceList = tempList;
  }

  getFromJsonData() {
    int trueCount = 0;
    for (int i = 0; i < tripController.serviceList.length; i++) {
      for (int y = 0; y < 4; y++) {
        if (tripController.serviceList[i] == _serviceList[y]) {
          _selectedList[y] = true;
          trueCount++;
        }
      }
    }

    for (int i = trueCount; i < tripController.serviceList.length; i++)
      _serviceListCustom.add(tripController.serviceList[i]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: CustomScrollView(slivers: [
        SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
          Color color = _selectedList[index] ? Colors.orange : Colors.grey;
          return GestureDetector(
            onTap: () {
              _selectedList[index] = !_selectedList[index];

              setState(() {});
            },
            child: Container(
              height: 55,
              padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
              decoration: BoxDecoration(border: Border.all(color: color)),
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                    _serviceList[index],
                    style: TextStyle(
                        color: color, fontSize: _selectedList[index] ? 16 : 15),
                  )),
                  Icon(
                    _selectedList[index] ? Icons.done : Icons.circle_rounded,
                    size: _selectedList[index] ? 15 : 10,
                    color: color,
                  )
                ],
              ),
            ),
          );
        }, childCount: _serviceList.length)),
        SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
            margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
            decoration: BoxDecoration(border: Border.all(color: Colors.orange)),
            child: Row(
              children: [
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    _addServiceController.text = _serviceListCustom[index];
                    _serviceListCustom.removeAt(index);
                    setState(() {});
                    myFocusNode.requestFocus();
                  },
                  child: SizedBox(
                    child: Text(
                      _serviceListCustom[index],
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                )),
                GestureDetector(
                  onTap: () {
                    _serviceListCustom.removeAt(index);
                    setState(() {});
                  },
                  child: Icon(Icons.close),
                )
              ],
            ),
          );
        }, childCount: _serviceListCustom.length)),
        SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            child: CupertinoTextField(
                focusNode: myFocusNode,
                onSubmitted: (value) {
                  _serviceListCustom.add(value);
                  _addServiceController.clear();
                  setState(() {});
                },
                controller: _addServiceController,
                placeholder: "Thêm mục...",
                clearButtonMode: OverlayVisibilityMode.editing,
                style: TextStyle(color: Colors.white),
                decoration: BoxDecoration(
                  border: Border.all(style: BorderStyle.none),
                )),
          ),
        ),
        SliverToBoxAdapter(
            child: Container(
          height: 400,
        ))
      ]),
    );
  }
}
