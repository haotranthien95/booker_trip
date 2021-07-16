import 'dart:async';
import 'package:new_ecom_project/core/modules/createTripFileHelp.dart';
import 'package:new_ecom_project/ui/modules/tripCreatePage/bookingSlotNewTrip/slotTypeController/slotObject.dart';

class SlotControllerBloc {
  final _slotController = StreamController<List<int>>();
  List<SlotObject> _listObject = [];
  int _inSelected = 0;
  int _lastSelected = 0;

  Stream<List<int>> get changeSlotStream => _slotController.stream;

  setListObject(List<SlotObject> list) => _listObject = list;

  getListObjectFromJson() {
    List<SlotObject> tmpList = [];
    for (var slot in tripController.slotInfo) {
      tmpList.add(SlotObject(
          title: slot.title,
          type: slot.slotType,
          slot: slot.adult,
          childSlot: slot.child,
          price: slot.price,
          maxCount: slot.slot,
          desc: slot.content));
    }
    _listObject = tmpList;
  }

  onCreateNewSlot(int lastIndex) {
    SlotObject obj = SlotObject();
    _inSelected = 1;
    _listObject.add(obj);
    tripController.slotInfo.add(SlotInfo(
        title: obj.title,
        slotType: obj.type,
        adult: obj.slot,
        child: obj.childSlot,
        price: obj.price,
        slot: obj.maxCount,
        content: obj.desc));
    _lastSelected = lastIndex;
    _slotController.sink.add([_lastSelected, _inSelected]);
  }

  updateOnly(int index) {
    _slotController.sink.add([_lastSelected, _inSelected]);
  }

  onUpdateSlotInfo(SlotObject slotObject, int index) {
    print("Update ${slotObject.title}");
    _listObject[index].setChildSlot(slotObject.childSlot);
    _listObject[index].setDesc(slotObject.desc);
    _listObject[index].setMaxCount(slotObject.maxCount);
    _listObject[index].setPrice(slotObject.price);
    _listObject[index].setSLot(slotObject.slot);
    _listObject[index].setTitle(slotObject.title);
    _listObject[index].setType(slotObject.type);
    tripController.slotInfo[index] = SlotInfo(
        title: slotObject.title,
        slotType: slotObject.type,
        adult: slotObject.slot,
        child: slotObject.childSlot,
        price: slotObject.price,
        slot: slotObject.maxCount,
        content: slotObject.desc);
    _slotController.sink.add([index, _inSelected]);
  }

  onUpdateNumberTitle(int index, int number) {
    _listObject[index].setMaxCount(number);
    tripController.slotInfo[index].slot = number;
    _slotController.sink.add([_lastSelected, _inSelected]);
  }

  onCancelItem(int index) {
    if (index < _lastSelected) {
      _lastSelected--;
    } else if (index == _lastSelected) {
      _lastSelected = 0;
      _inSelected = 0;
    }
    _listObject.removeAt(index);
    tripController.slotInfo.removeAt(index);
    _slotController.sink.add([_lastSelected, _inSelected]);
  }

  onSelectedItem(int index) {
    _inSelected = 1;
    _lastSelected = index;
    _slotController.sink.add([_lastSelected, _inSelected]);
  }

  onUnSelectedItem(int index) {
    _inSelected = 0;
    _lastSelected = index;
    _slotController.sink.add([_lastSelected, _inSelected]);
  }

  get listObject => _listObject;
  dispose() {
    _slotController.close();
    print("Stream disposed");
  }
}
