import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_ecom_project/core/blocs/slotControllerBloc.dart';

import 'package:new_ecom_project/ui/modules/tripCreatePage/bookingSlotNewTrip/slotTypeController/typeTourNewTrip/typeTourPicker.dart';

import 'numberSlot/numberSlot.dart';
import 'slotObject.dart';

class SlotTypeController extends StatefulWidget {
  const SlotTypeController(
      {Key? key, required this.slotControllerBloc, required this.index})
      : super(key: key);
  final SlotControllerBloc slotControllerBloc;
  final int index;

  @override
  _SlotTypeControllerState createState() => _SlotTypeControllerState();
}

class _SlotTypeControllerState extends State<SlotTypeController> {
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descController = TextEditingController();
  String slotType = "";
  int slotCount = 0;
  int paxCount = 0;
  int childCount = 0;
  @override
  void initState() {
    titleController.text =
        widget.slotControllerBloc.listObject[widget.index].title;
    priceController.text =
        widget.slotControllerBloc.listObject[widget.index].price.toString();
    descController.text =
        widget.slotControllerBloc.listObject[widget.index].desc;
    slotType = widget.slotControllerBloc.listObject[widget.index].type;
    paxCount = widget.slotControllerBloc.listObject[widget.index].slot;
    slotCount = widget.slotControllerBloc.listObject[widget.index].maxCount;
    childCount = widget.slotControllerBloc.listObject[widget.index].childSlot;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 10, top: 10),
        padding: EdgeInsets.all(10),
        color: Colors.black,
        child: Column(
          children: [
            CupertinoTextField(
              controller: titleController,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              placeholder: "Loại chỗ ngủ",
              style: TextStyle(color: Colors.white),
              clearButtonMode: OverlayVisibilityMode.editing,
            ),
            SlotTypePicker(
              datalabel: slotType,
              onPicked: (value) => slotType = value,
            ),
            NumberSlot(
              childCount: childCount,
              paxCount: paxCount,
              onAdultChange: (value) => paxCount = value,
              onChildChange: (value) => childCount = value,
            ),
            CupertinoTextField(
              controller: priceController,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[0-9]')),
              ],
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              placeholder: "Giá",
              style: TextStyle(color: Colors.white),
              clearButtonMode: OverlayVisibilityMode.editing,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: CupertinoTextField(
                controller: descController,
                padding: EdgeInsets.all(10),
                minLines: 2,
                maxLines: 6,
                maxLength: 300,
                decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                placeholder: "Mô tả...",
                style: TextStyle(color: Colors.white, fontSize: 13),
                clearButtonMode: OverlayVisibilityMode.editing,
              ),
            ),
            Container(
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                      child: Container(
                          alignment: AlignmentDirectional.bottomStart,
                          padding: EdgeInsets.only(left: 20),
                          child: Text("Chỗ",
                              style: TextStyle(
                                  fontSize: 15, color: Colors.grey[400])))),
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          minimumSize: Size(30, 30),
                          side: BorderSide(color: Colors.blue),
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          shape: CircleBorder()),
                      onPressed: () {
                        if (slotCount > 1) {
                          setState(() {
                            slotCount--;
                          });
                          widget.slotControllerBloc.listObject[widget.index]
                              .setMaxCount(slotCount);
                          widget.slotControllerBloc.updateOnly(widget.index);
                        }
                      },
                      child: Icon(Icons.remove)),
                  Container(
                      width: 25,
                      alignment: AlignmentDirectional.center,
                      child: Text(
                        slotCount.toString(),
                        textScaleFactor: 1.3,
                      )),
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          minimumSize: Size(30, 30),
                          side: BorderSide(color: Colors.blue),
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          shape: CircleBorder()),
                      onPressed: () {
                        if (slotCount < 99) {
                          setState(() {
                            slotCount++;
                            widget.slotControllerBloc.listObject[widget.index]
                                .setMaxCount(slotCount);
                            widget.slotControllerBloc.updateOnly(widget.index);
                          });
                        }
                      },
                      child: Icon(Icons.add)),
                  Padding(
                    padding: const EdgeInsets.only(left: 2, right: 2),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepOrange,
                        padding: EdgeInsets.all(10),
                      ),
                      onPressed: () {
                        widget.slotControllerBloc.onCancelItem(widget.index);
                      },
                      child: Text(
                        "Xóa",
                        textScaleFactor: 1,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 2, right: 2),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.orange,
                        padding: EdgeInsets.all(10),
                      ),
                      onPressed: () {
                        widget.slotControllerBloc
                            .onUnSelectedItem(widget.index);
                      },
                      child: Text(
                        "Quay lại",
                        textScaleFactor: 1,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 2, right: 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        padding: EdgeInsets.all(10),
                      ),
                      onPressed: () {
                        print("Thêm mục mới...");
                        SlotObject item = SlotObject(
                            childSlot: childCount,
                            slot: paxCount,
                            desc: descController.text,
                            maxCount: slotCount,
                            price: priceController.text == ""
                                ? 0
                                : int.parse(priceController.text),
                            title: titleController.text,
                            type: slotType);
                        widget.slotControllerBloc
                            .onUpdateSlotInfo(item, widget.index);
                        widget.slotControllerBloc
                            .onUnSelectedItem(widget.index);
                      },
                      child: Text(
                        "Lưu",
                        textScaleFactor: 1,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
