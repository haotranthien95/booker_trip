import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class NewFeedBookingForm extends StatefulWidget {
  @override
  _NewFeedBookingFormState createState() => _NewFeedBookingFormState();
}

class _NewFeedBookingFormState extends State<NewFeedBookingForm> {
  TextEditingController? _textController;
  FocusNode? _focusNode;
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode!.addListener(() {
      print('Listener');
    });
    _textController = TextEditingController();
    //_focusNode.requestFocus();
  }

  void dispose() {
    _focusNode!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void showKeyboard() {
      _focusNode!.requestFocus();
    }

    return Container(
      decoration: BoxDecoration(
          color: Colors.white12,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      padding: EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width * 0.96,
      child: Center(
        child: Column(
          children: [
            CupertinoTextField(
              decoration: BoxDecoration(
                color: Colors.black26,
              ),
              textInputAction: TextInputAction.continueAction,
              controller: _textController,
              focusNode: _focusNode,
              placeholder: 'Bạn muốn đi đâu...',
              onTap: () {
                showKeyboard();
              },
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
    _selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2000),
          lastDate: DateTime(2025),
          initialEntryMode: DatePickerEntryMode.inputOnly);
      if (picked != null && picked != selectedDate)
        setState(() {
          selectedDate = picked;
        });
    }
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

    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.only(left: 4, right: 4),
      decoration: BoxDecoration(border: Border.all(color: Colors.white12)),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 60,
            child: RaisedButton(
              onPressed: () {
                DatePicker.showDatePicker(context,
                    theme: DatePickerTheme(
                        backgroundColor: Colors.grey.shade900,
                        itemStyle: TextStyle(color: Colors.white70),
                        cancelStyle:
                            TextStyle(color: Colors.blue, fontSize: 18),
                        doneStyle: TextStyle(color: Colors.blue, fontSize: 18)),
                    showTitleActions: true,
                    minTime: DateTime(1900, 1, 1),
                    maxTime: DateTime(2100, 12, 31), onConfirm: (date) {
                  print('confirm $date');
                  selectedDate = date;
                  setState(() {});
                }, currentTime: DateTime.now(), locale: LocaleType.vi);
              },
              color: Colors.orange,
              child: Icon(
                Icons.date_range_rounded,
              ),
            ),
          ),
          SizedBox(
            height: 40,
            width: 20.0,
          ),
          Text(
            "${selectedDate.toLocal()}".split(' ')[0],
          ),
          SizedBox(
            width: 20.0,
          ),
        ],
      ),
    );
  }
}
