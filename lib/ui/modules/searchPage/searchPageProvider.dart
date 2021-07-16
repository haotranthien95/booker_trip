import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class SearchPageProvider with ChangeNotifier {
  bool _filterOn = false;
  bool get filterOn => _filterOn;

  void switchFilter() {
    _filterOn = !_filterOn;
    print("switchFilter() called:${_filterOn.toString()}");
    notifyListeners();
  }

  void openFilter() {
    _filterOn = true;
    print("openFilter() called:${_filterOn.toString()}");
    notifyListeners();
  }

  void closeFilter() {
    _filterOn = false;
    print("closeFilter() called:${_filterOn.toString()}");
    notifyListeners();
  }
}
