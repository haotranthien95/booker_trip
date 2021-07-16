import 'package:flutter/material.dart';
import 'package:new_ecom_project/core/blocs/slotControllerBloc.dart';
import 'package:new_ecom_project/ui/modules/tripCreatePage/bookingSlotNewTrip/slotTypeController/slotObject.dart';

class SlotTypeShortTitle extends StatefulWidget {
  const SlotTypeShortTitle(
      {Key? key,
      required this.onCountChange,
      required this.slotControllerBloc,
      required this.index})
      : super(key: key);
  final Function(int) onCountChange;
  final int index;
  final SlotControllerBloc slotControllerBloc;

  @override
  _SlotTypeShortTitleState createState() => _SlotTypeShortTitleState();

  onTapItem() {
    print("Tap Tap Tap");
    slotControllerBloc.onSelectedItem(index);
  }
}

class _SlotTypeShortTitleState extends State<SlotTypeShortTitle> {
  int _maxCount = 1;

  @override
  Widget build(BuildContext context) {
    _maxCount = widget.slotControllerBloc.listObject[widget.index].maxCount;
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      color: Colors.black,
      child: Column(
        children: [
          Row(children: [
            Expanded(
              child: GestureDetector(
                onTap: () => widget.onTapItem(),
                child: Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(top: 10, bottom: 5),
                  child: Text(
                    "${widget.index + 1}.${widget.slotControllerBloc.listObject[widget.index].type}: ${widget.slotControllerBloc.listObject[widget.index].title}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            IconButton(
                onPressed: () {
                  widget.slotControllerBloc.onCancelItem(widget.index);
                },
                icon: Icon(Icons.close))
          ]),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => widget.onTapItem(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          child: Text(
                        'Dành cho ${widget.slotControllerBloc.listObject[widget.index].slot} người lớn${widget.slotControllerBloc.listObject[widget.index].childSlot == 0 ? "." : " và ${widget.slotControllerBloc.listObject[widget.index].childSlot} trẻ em."}',
                        style: TextStyle(fontSize: 14, color: Colors.grey[400]),
                      )),
                      Container(
                          child: Text(
                        'Giá ${widget.slotControllerBloc.listObject[widget.index].price}VND',
                        style:
                            TextStyle(fontSize: 14, color: Colors.orangeAccent),
                      )),
                      Container(
                          child: Text(
                        widget.slotControllerBloc.listObject[widget.index].desc,
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                      ))
                    ],
                  ),
                ),
              ),
              Container(
                child: Row(
                  children: [
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            minimumSize: Size(30, 30),
                            side: BorderSide(color: Colors.blue),
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            shape: CircleBorder()),
                        onPressed: () {
                          if (widget.slotControllerBloc.listObject[widget.index]
                                  .maxCount >
                              0) {
                            setState(() {
                              widget.slotControllerBloc.listObject[widget.index]
                                  .setMaxCount(widget.slotControllerBloc
                                          .listObject[widget.index].maxCount -
                                      1);
                              _maxCount = widget.slotControllerBloc
                                  .listObject[widget.index].maxCount;
                              widget.onCountChange(_maxCount);
                            });
                          }
                        },
                        child: Icon(Icons.remove)),
                    Container(
                        width: 25,
                        alignment: AlignmentDirectional.center,
                        child: Text(
                          _maxCount.toString(),
                          textScaleFactor: 1.3,
                        )),
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            minimumSize: Size(30, 30),
                            side: BorderSide(color: Colors.blue),
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            shape: CircleBorder()),
                        onPressed: () {
                          if (widget.slotControllerBloc.listObject[widget.index]
                                  .maxCount <
                              99) {
                            setState(() {
                              widget.slotControllerBloc.listObject[widget.index]
                                  .setMaxCount(widget.slotControllerBloc
                                          .listObject[widget.index].maxCount +
                                      1);
                              _maxCount = widget.slotControllerBloc
                                  .listObject[widget.index].maxCount;
                              widget.onCountChange(_maxCount);
                            });
                          }
                        },
                        child: Icon(Icons.add)),
                  ],
                ),
              )
            ],
          ),
          Divider(
            color: Colors.grey[400],
            thickness: 1,
            height: 30,
          )
        ],
      ),
    );
  }
}
