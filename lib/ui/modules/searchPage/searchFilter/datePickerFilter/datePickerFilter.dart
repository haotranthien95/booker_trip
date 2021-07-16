import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class DatePickerFilter extends StatefulWidget {
  @override
  _DatePickerFilterState createState() => _DatePickerFilterState();
}

class _DatePickerFilterState extends State<DatePickerFilter> {
  FocusNode? _focusNode;
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode!.addListener(() {
      print('Listener');
    });
    //_focusNode.requestFocus();
  }

  void dispose() {
    _focusNode!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
      ),
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Center(
        child: Column(
          children: [
            Container(
              alignment: AlignmentDirectional.centerStart,
              child:
                  Text("Thời gian", style: TextStyle(color: Colors.grey[400])),
            ),
            DatePickerBooking(),
            DatePickerBooking()
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}

class DatePickerBooking extends StatefulWidget {
  const DatePickerBooking({
    Key? key,
  }) : super(key: key);

  @override
  _DatePickerBookingState createState() => _DatePickerBookingState();
}

class _DatePickerBookingState extends State<DatePickerBooking> {
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    // _selectDate(BuildContext context) async {
    //   final DateTime? picked = await showDatePicker(
    //       context: context,
    //       initialDate: selectedDate,
    //       firstDate: DateTime(2000),
    //       lastDate: DateTime(2025),
    //       initialEntryMode: DatePickerEntryMode.inputOnly);
    //   if (picked != null && picked != selectedDate)
    //     setState(() {
    //       selectedDate = picked;
    //     });
    // }

    return OutlinedButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
      ),
      onPressed: () {
        DatePicker.showDatePicker(context,
            theme: DatePickerTheme(
                backgroundColor: Colors.grey.shade900,
                itemStyle: TextStyle(color: Colors.white70),
                cancelStyle: TextStyle(color: Colors.orange, fontSize: 18),
                doneStyle: TextStyle(color: Colors.orange, fontSize: 18)),
            showTitleActions: true,
            minTime: DateTime(1900, 1, 1),
            maxTime: DateTime(2100, 12, 31), onConfirm: (date) {
          print('confirm $date');
          selectedDate = date;
          setState(() {});
        }, currentTime: DateTime.now(), locale: LocaleType.vi);
      },
      child: Container(
        //margin: EdgeInsets.only(top: 8),
        padding: EdgeInsets.only(left: 4, right: 4),
        //decoration: BoxDecoration(border: Border.all(color: Colors.white24)),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 60,
              child: Icon(Icons.date_range_rounded, color: Colors.orange),
            ),
            SizedBox(
              height: 40,
              width: 20.0,
            ),
            Text(
              "${selectedDate.day}, Tháng ${selectedDate.month}, Năm ${selectedDate.year}",
              style: TextStyle(color: Colors.deepOrange),
            ),
            SizedBox(
              width: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
