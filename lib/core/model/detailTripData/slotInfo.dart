class SlotInfor {
  int _id = 0; // "id": 128,
  String _tripCode = ''; //           "trip_code": "20210714111554665",
  int _slotSeq = 0; //           "slot_seq": 2,
  String _title = ''; //           "title": "Võng 2 lớp Nature Hike có tăng",
  String _slotType = ''; //           "slot_type": "Võng",
  int _adult = 0; //           "adult": 1,
  int _child = 0; //           "child": 0,
  int _price = 0; //           "price": 500000,
  String _content =
      ''; //           "content": "Võng 2 lớp đem lại cảm giác an toàn ấm cúng không sợ mưa gió. Có trang bị sẵn dây treo balo, túi ngủ cùng một số vật dụng cần thiết khác",
  int _slot = 0; //           "slot": 5,
  int _status = 0; //           "status": 10,
  int _discountPrice = 0; //           "dis_price": null,
  double _discountRate = 0; //           "rate": null,
  int _discountType = 0; //       "type": null,
  int _bookedSlot = 0; //           "booked_slot": null,

  int get id => this._id;
  set id(int value) => this._id = value;
  String get tripCode => this._tripCode;
  set tripCode(String value) => this._tripCode = value;
  int get slotSeq => this._slotSeq;
  set slotSeq(int value) => this._slotSeq = value;
  String get title => this._title;
  set title(String value) => this._title = value;
  String get slotType => this._slotType;
  set slotType(String value) => this._slotType = value;
  int get adult => this._adult;
  set adult(int value) => this._adult = value;
  int get child => this._child;
  set child(int value) => this._child = value;
  get price => this._price;
  set price(value) => this._price = value;
  String get content => this._content;
  set content(String value) => this._content = value;
  int get slot => this._slot;
  set slot(int value) => this._slot = value;
  int get status => this._status;
  set status(int value) => this._status = value;
  int get discountPrice => this._discountPrice;
  set discountPrice(int value) => this._discountPrice = value;
  double get discountRate => this._discountRate;
  set discountRate(double value) => this._discountRate = value;
  int get discountType => this._discountType;
  set discountType(int value) => this._discountType = value;
  int get bookedSlot => this._bookedSlot;
  set bookedSlot(int value) => this._bookedSlot = value;

  SlotInfor.fromObject(dynamic objData) {
    _id = objData['id'];
    _tripCode =
        objData['trip_code']; //           "trip_code": "20210714111554665",
    _slotSeq = objData['slot_seq']; //           "slot_seq": 2,
    _title = objData[
        'title']; //           "title": "Võng 2 lớp Nature Hike có tăng",
    _slotType = objData['slot_type']; //           "slot_type": "Võng",
    _adult = objData['adult']; //           "adult": 1,
    _child = objData['child']; //           "child": 0,
    _price = objData['price']; //           "price": 500000,
    _content =
        objData['content']; //           "content":  vật dụng cần thiết khác",
    _slot = objData['slot']; //           "slot": 5,
    _status = objData['status']; //           "status": 10,
    _discountRate = objData['rate'] ?? 0; //           "rate": null,
    _discountType = objData['type'] ?? 1; //       "type": null,
    _bookedSlot = objData['booked_slot'] ?? 0; //           "booked_slot": null,
    if (objData['type'] == 2) {
      _discountPrice = objData['price'] * (1 - objData['rate']);
    } else {
      _discountPrice = objData['dis_price'] ??
          objData['price']; //           "dis_price": null,
    }
  }
}
