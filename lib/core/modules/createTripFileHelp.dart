import 'dart:async';
import 'dart:io';
import 'package:new_ecom_project/core/blocs/uploadTripBloc.dart' as uploadBloc;
import 'package:new_ecom_project/core/blocs/uploadTripBloc.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:path_provider/path_provider.dart' as pat;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:convert';

class TripRegisterController {
  List<File> _imageList = [];
  // late TripRegisterInfo tripRegisterInfo;
  static Future readCounter() async {
    try {
      final dir = await pat.getTemporaryDirectory();
      print(dir.path);

      Iterable<FileSystemEntity> jsonFile =
          Directory(dir.path).listSync().where((element) {
        return element.path.endsWith('trip_detail.json');
      });
      print("readCounter:Mark1");
      if (jsonFile.isEmpty) {
        print(tripController.toJSON());
      } else {
        final file = File("/${dir.path}/trip_detail.json");
        final contents = await file.readAsString();
        tripController.fromJSON(contents);
        print(tripController.toJSON());
      }
    } catch (e) {
      // If encountering an error, return 0
      print(e.toString());
    }
  }

  Future writeCounter() async {
    print("SAVE");
    final dir = await pat.getTemporaryDirectory();
    Future<Iterable<FileSystemEntity>> jsonFile;
    Future(() async {
      return Directory(dir.path).listSync().where((element) {
        return element.path.endsWith('trip_detail.json');
      });
    }).then((value) {
      File newFile = File(dir.path + "/trip_detail.json");
      newFile.writeAsString(tripController.toJSON());
    }).onError((error, stackTrace) =>
        throw Exception("ERROR:writeCounter:$error:stackTrace:$stackTrace"));
  }

  static Future<bool> fileExisted() async {
    final dir = await pat.getTemporaryDirectory();
    Iterable<FileSystemEntity> fileList =
        Directory(dir.path).listSync().where((element) {
      return element.path.endsWith('-trip.jpg');
    });
    return fileList.isEmpty ? false : true;
  }

  Future<void> getAllFile(UploadTripBloc bloc) async {
    await _getAllFile(bloc).then((value) => bloc.createTripAPICall());
  }

  Future<void> _getAllFile(UploadTripBloc bloc) async {
    int dataCount = 0;
    List<String> pathList = [];
    final dir = await pat.getTemporaryDirectory();
    Iterable<FileSystemEntity> fileList =
        Directory(dir.path).listSync().where((element) {
      //print(element.path.endsWith('-trip.jpg'));
      return element.path.endsWith('-trip.jpg');
    });
    fileList.forEach((element) {
      pathList.add(element.path);
    });
    pathList.sort();
    pathList.forEach((element) {
      _imageList.add(File(element));
    });
    for (var file in _imageList) {
      await postImage(file, (snapshot) {
        snapshot.listen((event) {
          double percent =
              (event.bytesTransferred / event.totalBytes / _imageList.length +
                      dataCount / _imageList.length)
                  .toDouble();
          bloc.percentUpdate(percent);
        });
      });
      dataCount++;
    }
  }

  Future<dynamic> postImage(
      File file, Function(Stream<firebase_storage.TaskSnapshot>) func) async {
    String fileBaseDirectory =
        "/tripsImage/trip-${DateTime.now().microsecondsSinceEpoch}.jpg";
    firebase_storage.FirebaseStorage.instance;

    firebase_storage.Reference reference = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child(fileBaseDirectory);

    firebase_storage.UploadTask uploadTask = reference.putFile(file);
    func(uploadTask.snapshotEvents);

    firebase_storage.TaskSnapshot storageTaskSnapshot =
        await uploadTask.then((value) {
      print(value.toString());
      return value;
    });

    String value = await storageTaskSnapshot.ref.getDownloadURL().then((value) {
      print(value);
      return value;
    });
    tripController._imageLinkList.add(value);
  }
}

final tripController = TripRegisterInfo();

class TripRegisterInfo {
  TripRegisterInfo() {
    print("OMG: NO TAO LIEN TUC LUON NE");
  }
  //First page
  String _title = "";
  DateTime _startDate = DateTime.utc(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 8);
  DateTime _toDate = DateTime.utc(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 20);
  String _tripType = "";

  //Second Page
  String _addressProvince = "";
  String _addressTown = "";
  String _addressVillage = "";
  LatLng _location = LatLng(0, 0);
  //Slot
  List<SlotInfo> _slotInfo = [];
  //Image
  List<String> _imageLinkList = [];
  //Service
  List<String> _serviceList = [];
  //content
  String _content = "";

  String get title => this._title;
  set title(String value) => this._title = value;
  DateTime get startDate => this._startDate;
  set startDate(DateTime value) => this._startDate = value;
  DateTime get toDate => this._toDate;
  set toDate(DateTime value) => this._toDate = value;
  String get tripType => this._tripType;
  set tripType(String value) => this._tripType = value;
  String get addressProvince => this._addressProvince;
  set addressProvince(String value) => this._addressProvince = value;
  String get addressTown => this._addressTown;
  set addressTown(String value) => this._addressTown = value;
  String get addressVillage => this._addressVillage;
  set addressVillage(String value) => this._addressVillage = value;
  LatLng get location => this._location;
  set location(LatLng value) => this._location = value;
  List<SlotInfo> get slotInfo => this._slotInfo;
  set slotInfo(List<SlotInfo> value) => this._slotInfo = value;
  List<String> get imageLinkList => this._imageLinkList;
  set imageLinkList(List<String> value) => this._imageLinkList = value;
  List<String> get serviceList => this._serviceList;
  set serviceList(List<String> value) => this._serviceList = value;
  String get content => this._content;
  set content(String value) => this._content = value;

  String toJSON() {
    String slotInfoJSONString = '';
    bool firstData = true;
    for (var object in _slotInfo) {
      slotInfoJSONString =
          slotInfoJSONString + (firstData ? '' : ',') + object.toJSON();
      firstData = false;
    }
    firstData = true;
    String imageListtoJSONString = '';
    for (var link in _imageLinkList) {
      imageListtoJSONString =
          imageListtoJSONString + (firstData ? '' : ',') + '{"link": "$link"}';
      firstData = false;
    }
    String serviceListtoJSONString = '';
    firstData = true;
    for (var service in _serviceList) {
      serviceListtoJSONString = serviceListtoJSONString +
          (firstData ? '' : ',') +
          '{"service": "$service"}';
      firstData = false;
    }

    String _value = "";

    _value = '''{"title":"$_title",
    "startDate":"${DateFormat("yyyy-MM-dd kk:mm:ss").format(_startDate)}",
    "toDate":"${DateFormat("yyyy-MM-dd kk:mm:ss").format(_toDate)}",
    "tripType":"$_tripType",
    "addressProvince":"$_addressProvince",
    "addressTown":"$_addressTown",
    "addressVillage":"$_addressVillage",
    "lat":${_location.latitude},
    "long":${_location.longitude},
    "slotInfo":[$slotInfoJSONString],
    "imageLinkList":[$imageListtoJSONString],
    "serviceList":[$serviceListtoJSONString],
    "content":"$_content"}
    ''';
    final object = json.decode(_value);

    String result = JsonEncoder.withIndent('  ').convert(object);

    return result;
  }

  TripRegisterInfo.fromJSON(String jsonData) {
    var objData = json.decode(jsonData);
    _title = objData['title'];
    _startDate = DateTime.parse(objData['startDate']);
    _toDate = DateTime.parse(objData['toDate']);
    _tripType = objData['tripType'];
    _addressProvince = objData['addressProvince'];
    _addressTown = objData['addressTown'];
    _addressVillage = objData['addressVillage'];
    _location = LatLng(objData['lat'], objData['long']);
    _slotInfo.clear();
    _imageLinkList.clear();
    _serviceList.clear();
    for (var slot in objData['slotInfo']) {
      _slotInfo.add(SlotInfo.fromObj(slot));
    }
    for (var slot in objData['imageLinkList']) {
      _imageLinkList.add(slot);
    }
    for (var slot in objData['serviceList']) {
      _serviceList.add(slot);
    }
    _content = objData['content'];
  }
  fromJSON(String jsonData) {
    var objData = json.decode(jsonData);
    _title = objData['title'];
    _startDate = DateTime.parse(objData['startDate']);
    _toDate = DateTime.parse(objData['toDate']);
    _tripType = objData['tripType'];
    _addressProvince = objData['addressProvince'];
    _addressTown = objData['addressTown'];
    _addressVillage = objData['addressVillage'];
    _location = LatLng(objData['lat'], objData['long']);
    print(_serviceList.toString());
    _slotInfo.clear();
    _imageLinkList.clear();
    _serviceList.clear();
    for (var slot in objData['slotInfo']) {
      _slotInfo.add(SlotInfo.fromObj(slot));
    }
    for (var slot in objData['imageLinkList']) {
      _imageLinkList.add(slot);
    }
    for (var slot in objData['serviceList']) {
      _serviceList.add(slot["service"]);
    }
    _content = objData['content'];
    print(_serviceList.toString());
  }

  // //Second Page
  // String _addressProvince = "";
  // String _addressTown = "";
  // String _addressVillage = "";
  // LatLng _location = LatLng(10, 10);
  // //Slot
  // List<SlotInfo> _slotInfo = [];
  // //Image
  // List<String> _imageLinkList = [];
  // //Service
  // List<String> _serviceList = [];
  // //content
  // String _content = "";
}

class SlotInfo {
  SlotInfo(
      {String title = "",
      String slotType = "",
      int adult = 0,
      int child = 0,
      int price = 0,
      String content = "",
      int slot = 0}) {
    _title = title;
    _slotType = slotType;
    _adult = adult;
    _child = child;
    _price = price;
    _content = content;
    _slot = slot;
  }
  String _title = "";
  String _slotType = "";
  int _adult = 0;
  int _child = 0;
  int _price = 0;
  String _content = "";
  int _slot = 0;

  String get slotType => this._slotType;
  set slotType(String value) => this._slotType = value;
  int get adult => this._adult;
  set adult(int value) => this._adult = value;
  int get child => this._child;
  set child(int value) => this._child = value;
  int get price => this._price;
  set price(int value) => this._price = value;
  String get title => this._title;
  set title(String value) => this._title = value;
  String get content => this._content;
  set content(String value) => this._content = value;
  int get slot => this._slot;
  set slot(int value) => this._slot = value;

  String toJSON() {
    String _value = "";
    _value = '''{"title":"$_title",
    "slotType":"$_slotType",
    "adult":$_adult,
    "child":$_child,
    "price":$_price,
    "content":"$_content",
    "slot":$_slot
    }''';
    final object = json.decode(_value);
    String result = JsonEncoder.withIndent('  ').convert(object);
    return result;
  }

  SlotInfo.fromJSON(String jsonData) {
    var objData = json.decode(jsonData);
    _title = objData['title'];
    _slotType = objData['slotType'];
    _adult = objData['adult'];
    _child = objData['child'];
    _price = objData['price'];
    _content = objData['content'];
    _slot = objData['slot'];
  }
  fromJSON(String jsonData) {
    var objData = json.decode(jsonData);
    _title = objData['title'];
    _slotType = objData['slotType'];
    _adult = objData['adult'];
    _child = objData['child'];
    _price = objData['price'];
    _content = objData['content'];
    _slot = objData['slot'];
  }

  SlotInfo.fromObj(objData) {
    _title = objData['title'];
    _slotType = objData['slotType'];
    _adult = objData['adult'];
    _child = objData['child'];
    _price = objData['price'];
    _content = objData['content'];
    _slot = objData['slot'];
  }
}
