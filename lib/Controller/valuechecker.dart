import 'package:flutter/foundation.dart';

class valueUpdater with ChangeNotifier {
  int _value = 2;
  int get getValue => _value;
  set valueSet(int updatevalue) {
    _value = updatevalue;
    notifyListeners();
  }
}
