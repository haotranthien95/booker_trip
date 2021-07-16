import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/foundation.dart';
import 'package:new_ecom_project/core/services/repository.dart';

class SearchingHintBloc {
  final _repository = Repository();
  final _hintController = StreamController<List<String>>();
  final _enableHintLabelController = StreamController<bool>();
  Timer _debounce = Timer(const Duration(milliseconds: 500), () {
    print("Start timer");
  });
  var periodStream = Stream.periodic(Duration(seconds: 5), (int i) {
    return "=== Hint Stream is active!!![${(i + 1) * 5}s]";
  }).listen(print, onDone: () => print('Done!'));
  Stream<List<String>> get onHintCall => _hintController.stream;
  Stream<bool> get onnableHintLabelCall => _enableHintLabelController.stream;

  onChangeText(String textInput) async {
    _debounce.isActive ? _debounce.cancel() : print("Nothing tocancel");
    _debounce = Timer(const Duration(milliseconds: 500), () {
      onHintController(textInput);
    });
  }

  onGetHotKeyWord() async {
    await _repository.getHotKeyList().then((value) {
      _enableHintLabelController.sink.add(true);
      _hintController.sink.add(value);
    });
  }

  onHintController(String textInput) async {
    final List<String> myList = [
      "nguoi",
      "nguoi ve",
      "nguoi ve tu long dat",
      "nguoi ve day ben anh"
    ];
    _enableHintLabelController.sink.add(textInput == '' ? true : false);
    _hintController.sink.add(myList);
    print(myList.length);
  }

  void dispose() {
    _hintController.close();
    periodStream.cancel();
    _enableHintLabelController.close();
    print("SearchingHintBloc:Stream disposed");
  }
}

//final searchingHintBloc = SearchingHintBloc();

