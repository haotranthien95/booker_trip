import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_ecom_project/core/modules/createTripFileHelp.dart';

class ContentNewTrip extends StatelessWidget {
  const ContentNewTrip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _textController =
        TextEditingController(text: tripController.content);
    Timer _debounce = Timer(const Duration(milliseconds: 500), () {});
    return Container(
        color: Colors.black,
        child: CustomScrollView(slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: CupertinoTextField(
                      onChanged: (text) {
                        _debounce.isActive
                            ? _debounce.cancel()
                            : print("Nothing tocancel");
                        _debounce =
                            Timer(const Duration(milliseconds: 500), () {
                          tripController.content = text;
                          print(tripController.content);
                        });
                      },
                      padding: EdgeInsets.all(10),
                      maxLength: 2000,
                      minLines: 4,
                      maxLines: 20,
                      controller: _textController,
                      placeholder: "Nội dung...",
                      clearButtonMode: OverlayVisibilityMode.editing,
                      style: TextStyle(color: Colors.white, fontSize: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[900],
                      )),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "Nhập nội dung chuyến đi, lịch trình và các lưu ý của bạn.",
                          style: TextStyle(color: Colors.grey)),
                      Text("Độ dài tối đa 2000 ký tự",
                          style: TextStyle(color: Colors.grey, height: 1.5)),
                    ],
                  ),
                )
              ],
            ),
          )
        ]));
  }
}
