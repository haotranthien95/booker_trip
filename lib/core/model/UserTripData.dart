import 'dart:convert';

class UserTripObject {
  UserTripObject();

  String _tripID = ''; //Bokor CampSite
  String _tripCode = ''; //Bokor CampSite
  String _headerName = ''; //Bokor CampSite
  String _hostName = '';
  bool _rateStatus = false; // true
  double _rateScore = 0; //4,0
  DateTime _startDate = DateTime.now();
  DateTime _toDate = DateTime.now();
  String _placeAddress = ''; //DaMi, Tanh Linh, Binh Thuan
  String _placeType = ''; // Jungle, Lake, Waterfall
  String _slotType = ''; //Combo hammock,BBQ
  String _finalPrice = ''; // 200000000VND
  String _oriPrice = ''; // 20000000VND
  int _remainSlot = 0; //5
  int _totalSlot = 0; //5
  String _promotion_1 = ''; // included taxes and fees
  String _promotion_2 = ''; // No prepayment needed
  String _imageLink = '';

  String get tripID => this._tripID;
  String get tripCode => this._tripCode;
  String get headerName => this._headerName;
  String get hostName => this._hostName;
  bool get rateStatus => this._rateStatus;
  double get rateScore => this._rateScore;
  DateTime get startDate => this._startDate;
  DateTime get toDate => this._toDate;
  String get placeAddress => this._placeAddress;
  String get placeType => this._placeType;
  String get slotType => this._slotType;
  String get finalPrice => this._finalPrice;
  String get oriPrice => this._oriPrice;
  int get remainSlot => this._remainSlot;
  int get totalSlot => this._totalSlot;
  String get promotion_1 => this._promotion_1;
  String get promotion_2 => this._promotion_2;
  String get imageLink => this._imageLink;

  set tripID(String value) => this._tripID = value;
  set tripCode(String value) => this._tripCode = value;
  set headerName(String value) => this._headerName = value;
  set hostName(String value) => this._hostName = value;
  set rateStatus(bool value) => this._rateStatus = value;
  set rateScore(double value) => this._rateScore = value;
  set startDate(DateTime value) => this._startDate = value;
  set toDate(DateTime value) => this._toDate = value;
  set placeAddress(String value) => this._placeAddress = value;
  set placeType(String value) => this._placeType = value;
  set slotType(String value) => this._slotType = value;
  set finalPrice(String value) => this._finalPrice = value;
  set oriPrice(String value) => this._oriPrice = value;
  set remainSlot(int value) => this._remainSlot = value;
  set totalSlot(int value) => this._totalSlot = value;
  set promotion_1(String value) => this._promotion_1 = value;
  set promotion_2(String value) => this._promotion_2 = value;
  set imageLink(String value) => this._imageLink = value;
  UserTripObject.fromObject(dynamic objData) {
    _tripID = objData['trip_id'].toString();

    _tripCode = objData['trip_code'];
    _headerName = objData['title'];
    _rateStatus = objData['rate_score'] > 5 ? true : false;
    _rateScore = double.parse(objData['rate_score'].toString());
    _startDate = DateTime.parse(objData['start_date']);
    _toDate = DateTime.parse(objData['to_date']);

    placeAddress =
        "${objData['address_village']}, ${objData['address_town']}, ${objData['address_province']}";
    _placeType = objData['trip_type'];
    _slotType = objData['slot_type'];

    _finalPrice = objData['final_price'].toString();
    _oriPrice = objData['ori_price'].toString();

    _slotType = objData['slot_type'];
    _remainSlot = objData['remain_slot'];
    _totalSlot = objData['total_slot'];

    _promotion_1 = objData['service_list'][0]['service'];
    _promotion_2 = objData['service_list'][1]['service'];
    _imageLink = objData['image_link'];
  }
  UserTripObject.fromJson(String jsonData) {
    var objData = json.decode(jsonData);
    _tripID = objData['trip_id'];
    _tripCode = objData['trip_code'];
    _headerName = objData['title'];
    _rateStatus = objData['rate_score'] > 5 ? true : false;
    _rateScore = objData['rate_score'];
    _startDate = DateTime.parse(objData['start_date']);
    _toDate = DateTime.parse(objData['to_date']);
    placeAddress =
        "${objData['address_village']}, ${objData['address_town']}, ${objData['address_province']}";
    _placeType = objData['trip_type'];
    _slotType = objData['slot_type'];
    _finalPrice = objData['final_price'].toString();
    _oriPrice = objData['ori_price'].toString();
    _slotType = objData['slot_type'];
    _remainSlot = objData['remain_slot'];
    _totalSlot = objData['total_slot'];
    _promotion_1 = objData['service_list'][0]['service'];
    _promotion_2 = objData['service_list'][1]['service'];
    _imageLink = objData['image_link'];
  }
  String toJSON() {
    String _value = "";
    _value = '''
    {"tripID":"$_tripID",
    "tripCode":"$_tripCode",
    "headerName":"$_headerName",
    "hostName":"$_hostName",
    "rateStatus":"$_rateStatus",
    "rateScore":"$_rateScore",
    "startDate":"$_startDate",
    "toDate":"$_toDate",
    "placeAddress":"$_placeAddress",
    "placeType":"$_placeType",
    "slotType":"$_slotType",
    "finalPrice":"$_finalPrice",
    "oriPrice":"$_oriPrice",
    "remainSlot":$_remainSlot,
    "totalSlot":$_totalSlot,
    "promotion_1":"$_promotion_1",
    "promotion_2":"$_promotion_2",
    "image_link":"$_imageLink"
    }''';
    final object = json.decode(_value);
    String result = JsonEncoder.withIndent('  ').convert(object);
    return result;
  }
}
