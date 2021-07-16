import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:new_ecom_project/core/modules/createTripFileHelp.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class DatePickerNewTrip extends StatefulWidget {
  @override
  _DatePickerNewTripState createState() => _DatePickerNewTripState();
}

class _DatePickerNewTripState extends State<DatePickerNewTrip> {
  DateTime beginDate = tripController.startDate;
  DateTime endDate = tripController.toDate;
  DateTime beginTime = tripController.startDate;
  DateTime endTime = tripController.toDate;
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
              child: Text("Thời gian",
                  style: TextStyle(color: Colors.grey[200], fontSize: 18)),
            ),
            selectDateTimeBuilder(context, 1, beginTime, beginDate, () {
              tripController.startDate = DateTime(
                  beginDate.year,
                  beginDate.month,
                  beginDate.day,
                  beginTime.hour,
                  beginTime.minute);
              print("Ngay bat dau: " + tripController.startDate.toString());
            }),
            selectDateTimeBuilder(context, 2, endTime, endDate, () {
              tripController.toDate = DateTime(endDate.year, endDate.month,
                  endDate.day, endTime.hour, endTime.minute);
              print("Ngay bat dau: " + tripController.toDate.toString());
            }),
            //TimePickerBooking(),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }

  Container selectDateTimeBuilder(BuildContext context, int begEnd,
      DateTime accessTime, DateTime accessDate, Function func) {
    String labelText =
        begEnd == 1 ? "Thời gian bắt đầu:" : "Thời gian kết thúc:";
    return Container(
      height: 105,
      child: Row(
        children: [
          Column(
            children: [
              OutlinedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                ),
                onPressed: () {
                  DatePicker.showTimePicker(context,
                      theme: DatePickerTheme(
                          backgroundColor: Colors.grey.shade900,
                          itemStyle: TextStyle(color: Colors.white70),
                          cancelStyle:
                              TextStyle(color: Colors.orange, fontSize: 18),
                          doneStyle:
                              TextStyle(color: Colors.orange, fontSize: 18)),
                      showTitleActions: true,
                      showSecondsColumn: false,
                      // minDate: DateTime(1900, 1, 1),
                      // maxTime: DateTime(2100, 12, 31),
                      onConfirm: (time) {
                    begEnd == 1 ? beginTime = time : endTime = time;
                    if (compareDateOnly(beginDate, endDate)) {
                      if (begEnd == 1) {
                        compareHourMinuteOnly(time, endTime) > 0
                            ? endTime = time
                            : DoNothingAction();
                      } else {
                        compareHourMinuteOnly(time, beginTime) < 0
                            ? beginTime = time
                            : DoNothingAction();
                      }
                    }
                    setState(() {});
                    func();
                  },
                      currentTime: begEnd != 1 ? endTime : beginTime,
                      locale: LocaleType.vi);
                },
                child: Container(
                  width: 90,
                  //margin: EdgeInsets.only(top: 8),
                  padding: EdgeInsets.only(left: 4, right: 8),
                  //decoration: BoxDecoration(border: Border.all(color: Colors.white24)),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: Icon(Icons.av_timer, color: Colors.orange),
                      ),
                      Text("Giờ"),
                    ],
                  ),
                ),
              ),
              OutlinedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                ),
                onPressed: () {
                  DatePicker.showDatePicker(context,
                      theme: DatePickerTheme(
                          backgroundColor: Colors.grey.shade900,
                          itemStyle: TextStyle(color: Colors.white70),
                          cancelStyle:
                              TextStyle(color: Colors.orange, fontSize: 18),
                          doneStyle:
                              TextStyle(color: Colors.orange, fontSize: 18)),
                      showTitleActions: true,
                      minTime: DateTime.now(),
                      maxTime: DateTime(2100, 12, 31), onConfirm: (date) {
                    print('confirm $date');
                    begEnd == 1 ? beginDate = date : endDate = date;
                    if (begEnd == 1) {
                      date.isAfter(endDate)
                          ? endDate = date
                          : DoNothingAction();
                    } else {
                      date.isBefore(beginDate)
                          ? beginDate = date
                          : DoNothingAction();
                    }
                    setState(() {});
                    func();
                  }, currentTime: DateTime.now(), locale: LocaleType.vi);
                },
                child: Container(
                  width: 90,
                  //margin: EdgeInsets.only(top: 8),
                  padding: EdgeInsets.only(left: 4, right: 8),

                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: Icon(Icons.date_range_rounded,
                            color: Colors.orange),
                      ),
                      Text("Ngày"),
                    ],
                  ),
                ),
              )
            ],
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 8, top: 4, bottom: 13),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  border: Border.all(color: Colors.white12, width: 1)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: Container(
                          alignment: Alignment.center, child: Text(labelText))),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "${accessTime.hour.toString().padLeft(2, '0')}:${accessTime.minute.toString().padLeft(2, '0')}, Ngày ${accessDate.day} ${monthFromInt(accessDate.month)}, ${accessDate.year}",
                        style: TextStyle(
                            color: Colors.deepOrange,
                            fontSize: 16,
                            wordSpacing: -1,
                            height: 0),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  bool compareDateOnly(DateTime date1, DateTime date2) {
    return (date1.day == date2.day &&
            date1.month == date2.month &&
            date1.year == date2.year)
        ? true
        : false;
  }

  int compareHourMinuteOnly(DateTime time1, DateTime time2) {
    if (time1.hour > time2.hour) {
      return 1;
    } else if (time1.hour < time2.hour) {
      return -1;
    }

    if (time1.minute == time2.minute) {
      return 0;
    }
    return (time1.minute > time2.minute) ? 1 : -1;
  }

  String monthFromInt(int month) {
    switch (month) {
      case 1:
        return "Tháng một";
      case 2:
        return "Tháng hai";
      case 3:
        return "Tháng ba";
      case 4:
        return "Tháng bốn";
      case 5:
        return "Tháng năm";
      case 6:
        return "Tháng sáu";
      case 7:
        return "Tháng bảy";
      case 8:
        return "Tháng tám";
      case 9:
        return "Tháng chín";
      case 10:
        return "Tháng mười";
      case 11:
        return "Tháng mười một";
      case 12:
        return "Tháng mười hai";
    }
    return "";
  }
}
