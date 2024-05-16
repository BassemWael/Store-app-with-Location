import 'package:flutter/foundation.dart';


class StoreData extends ChangeNotifier {
  double _lat = 0.0;
  double _lon = 0.0;

  double get lat => _lat;
  double get lon => _lon;

  setStoreData(double lat, double lon) {
    _lat = lat;
    _lon = lon;
    notifyListeners();
  }
}