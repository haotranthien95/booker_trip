import 'dart:async';
import 'package:new_ecom_project/core/sqlite/searchingHistory.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/foundation.dart';

class SearchingHistoryBloc {
  final _historyController = StreamController<List<String>>();
  final _enableHistoryLabelController = StreamController<bool>();
  DataBaseSearchingHistoryProvider dataBaseSearchingHistoryProvider =
      DataBaseSearchingHistoryProvider.databaseProvider;
  SearchingHistoryBloc() {
    dataBaseSearchingHistoryProvider.database;
  }
  Timer _debounce = Timer(const Duration(milliseconds: 500), () {
    print("Start timer");
  });

  var periodStream = Stream.periodic(Duration(seconds: 5), (int i) {
    return "=== History Stream is active!!![${(i + 1) * 5}s]";
  }).listen(print, onDone: () => print('Done!'));

  Stream<List<String>> get onHistoryCall => _historyController.stream;

  Stream<bool> get onnableHistoryLabelCall =>
      _enableHistoryLabelController.stream;
  onChangeText(String textInput) async {
    _debounce.isActive ? _debounce.cancel() : print("Nothing tocancel");
    _debounce = Timer(const Duration(milliseconds: 500), () {
      onHistoryController(textInput);
    });
  }

  clearHistory(String keyWord) async {
    await dataBaseSearchingHistoryProvider
        .clearHistory(keyWord)
        .then((value) => onHistoryController(""));
  }

  onSearch(String textInput) async {
    await dataBaseSearchingHistoryProvider.searchingCache(textInput);
  }

  onHistoryController(String textInput) async {
    List<String> listString = [];
    if (textInput.isEmpty) {
      var listObj =
          await dataBaseSearchingHistoryProvider.searchingHistoryQuery();

      for (var object in listObj) {
        listString.add(object['key_word'].toString());
      }
      print("^^^^^^^^^" + listString.length.toString());
    }
    final List<String> myList = [
      "Stephen Curry",
      "Jason Tatum",
      "Lebron James",
      "Kevin Durant",
      "Kyrie Irving",
      "James Harden",
    ];
    _historyController.sink.add(listString);
    _enableHistoryLabelController.sink
        .add((textInput == "" && listString.length > 0) ? true : false);
  }

  void dispose() {
    _historyController.close();
    _enableHistoryLabelController.close();
    periodStream.cancel();
    print("SearchingHistoryBloc:Stream disposed");
  }
}

//final searchingHistoryBloc = SearchingHistoryBloc();

