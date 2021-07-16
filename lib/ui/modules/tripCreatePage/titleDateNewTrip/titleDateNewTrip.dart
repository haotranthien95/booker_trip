import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'datePickerNewTrip/datePickerNewTrip.dart';
import 'typeTourNewTrip/typeTourPicker.dart';
import 'package:new_ecom_project/core/modules/createTripFileHelp.dart';

class TitleDateNewTrip extends StatefulWidget {
  const TitleDateNewTrip({Key? key}) : super(key: key);

  @override
  _TitleDateNewTripState createState() => _TitleDateNewTripState();
}

class _TitleDateNewTripState extends State<TitleDateNewTrip> {
  TextEditingController _textEditingController = TextEditingController();
  int a = 0;
  @override
  void initState() {
    TripRegisterController.readCounter().then((value) {
      a = 1;
      setState(() {
        _textEditingController.text = tripController.title;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (a == 0) {
      print("Builder lan dau ne");
      return Container();
    }
    print("Builder lan hai ne");
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: titleTextInputBuilder(),
        ),
        SliverToBoxAdapter(
          child: DatePickerNewTrip(),
        ),
        SliverToBoxAdapter(
          child: TypeTourPickerNewTrip(),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          fillOverscroll: true,
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 100, 10, 10),
            height: 200,
            width: 100,
            color: Colors.black,
          ),
        )
      ],
    );
  }

  Container titleTextInputBuilder() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
      ),
      padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
      child: Column(
        children: [
          Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 3),
              alignment: AlignmentDirectional.centerStart,
              child: Text("Tiêu đề",
                  style: TextStyle(fontSize: 18, color: Colors.grey[200]))),
          CupertinoTextField(
            controller: _textEditingController,
            onChanged: (text) {
              tripController.title = text;
            },
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.all(Radius.circular(5))),
            placeholder: "Tên chuyến đi của bạn...",
            style: TextStyle(color: Colors.white),
            clearButtonMode: OverlayVisibilityMode.editing,
          )
        ],
      ),
    );
  }
}
