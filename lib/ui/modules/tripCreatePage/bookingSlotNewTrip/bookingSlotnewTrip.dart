import 'package:flutter/material.dart';
import 'package:new_ecom_project/core/blocs/slotControllerBloc.dart';
import 'package:new_ecom_project/ui/modules/tripCreatePage/bookingSlotNewTrip/slotTypeController/slotObject.dart';
import 'package:new_ecom_project/ui/modules/tripCreatePage/bookingSlotNewTrip/slotTypeController/slotTypeController.dart';
import 'package:new_ecom_project/ui/modules/tripCreatePage/bookingSlotNewTrip/slotTypeShortTitle/slotTypeShortTitle.dart';

class BookingSlotNewTrip extends StatefulWidget {
  const BookingSlotNewTrip({Key? key}) : super(key: key);

  @override
  _BookingSlotNewTripState createState() => _BookingSlotNewTripState();
}

class _BookingSlotNewTripState extends State<BookingSlotNewTrip> {
  List<SlotObject> slotList = [];
  SlotControllerBloc slotControllerBloc = SlotControllerBloc();
  @override
  void dispose() {
    slotControllerBloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    //slotControllerBloc.setListObject(widget.slotList);
    slotControllerBloc.getListObjectFromJson();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<int>>(
        stream: slotControllerBloc.changeSlotStream,
        initialData: [0, 0],
        builder: (context, snapshot) {
          print("Rebuild");
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  color: Colors.black,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.orange,
                        padding: EdgeInsets.all(10),
                      ),
                      onPressed: () {
                        print("Thêm mục mới...");
                        slotControllerBloc.onCreateNewSlot(
                            slotControllerBloc.listObject.length);
                      },
                      child: Text(
                        "Thêm mục mới...",
                        textScaleFactor: 1.3,
                      ),
                    ),
                  ),
                ),
              ),
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                return slotTypeBuilder(
                    context,
                    index,
                    snapshot.data![0],
                    snapshot.data![1] == 0 ? false : true,
                    slotControllerBloc.listObject[index]);
              }, childCount: slotControllerBloc.listObject.length)),
              // SliverList(
              //     delegate: SliverChildBuilderDelegate(
              //         (BuildContext context, int index) {
              //   return SlotTypeShortTitle();
              // }, childCount: 3)),
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
        });
  }

  Widget slotTypeBuilder(BuildContext context, int index, int selectedIndex,
      bool inSelected, SlotObject slotObject) {
    //print("index:$index selectedIndex:$selectedIndex inSelected:$inSelected");
    if (inSelected && index == selectedIndex) {
      print("index:$index selectedIndex:$selectedIndex inSelected:$inSelected");
      return SlotTypeController(
        index: index,
        slotControllerBloc: slotControllerBloc,
      );
    } else {
      print("index:$index selectedIndex:$selectedIndex inSelected:$inSelected");
      return SlotTypeShortTitle(
        index: index,
        slotControllerBloc: slotControllerBloc,
        onCountChange: (value) {
          slotControllerBloc.listObject[index].setMaxCount(value);
          slotControllerBloc.updateOnly(index);
        },
      );
    }
  }
}
