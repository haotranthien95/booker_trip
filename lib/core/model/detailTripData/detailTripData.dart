import 'dart:convert';
import 'package:latlong2/latlong.dart';
import 'package:new_ecom_project/core/model/detailTripData/slotInfo.dart';

import 'package:new_ecom_project/core/modules/createTripFileHelp.dart';

class DetailTripObject {
  DetailTripObject();

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
  int _bookedSlot = 0; //5
  int _totalSlot = 0; //5

  List<SlotInfor> _slotInfo = [];
  List<String> _serviceInfo = [];
  List<String> _imageLink = [];
  List<String> _imagePath = [];

  LatLng _location = LatLng(0, 0);
  String _regisDate = ''; // included taxes and fees

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
  int get bookedSlot => this._bookedSlot;
  int get totalSlot => this._totalSlot;
  String get regisDate => this._regisDate;
  List<String> get imageLink => this._imageLink;
  List<String> get imagePath => this._imagePath;
  List<SlotInfor> get slotInfo => this._slotInfo;
  List<String> get serviceInfo => this._serviceInfo;
  LatLng get location => this._location;

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
  set bookedSlot(int value) => this._bookedSlot = value;
  set totalSlot(int value) => this._totalSlot = value;
  set regisDate(String value) => this._regisDate = value;
  set imageLink(List<String> value) => this._imageLink = value;
  set imagePath(List<String> value) => this._imagePath = value;
  set slotInfo(List<SlotInfor> value) => this._slotInfo = value;
  set serviceInfo(List<String> value) => this._serviceInfo = value;
  set location(LatLng value) => this._location = value;

  DetailTripObject.fromObject(dynamic objData) {
    print('a');
    _tripID = objData['trip_id'].toString();
    _hostName = objData['host_name'];
    _tripCode = objData['trip_code'];
    _headerName = objData['title'];
    _rateStatus = objData['rate_score'] > 5 ? true : false;
    print('b');
    _rateScore = double.parse(objData['rate_score'].toString());

    _startDate = DateTime.parse(objData['start_date']);
    _toDate = DateTime.parse(objData['to_date']);
    print('bb');

    placeAddress =
        "${objData['address_village']}, ${objData['address_town']}, ${objData['address_province']}";
    _placeType = objData['trip_type'];
    print('bbb');

    _bookedSlot = 0;
    _totalSlot = 0;
    _regisDate = objData['regis_date'];
    print('c');

    for (var object in objData['image_link_list']) {
      _imageLink.add(object['link']);
    }
    print('d');

    for (var object in objData['service_list']) {
      _serviceInfo.add(object['service']);
    }
    print('e');

    for (var object in objData['slot_list']) {
      _slotInfo.add(SlotInfor.fromObject(object));
    }

    for (var slot in _slotInfo) {
      _totalSlot = _totalSlot + slot.slot;
      _bookedSlot = _bookedSlot + slot.bookedSlot;
    }
    print('f');

    _location = LatLng(objData['lat'], objData["long"]);
  }
}
