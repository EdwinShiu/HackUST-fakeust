import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hackust_fakeust/models/area_model.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapDataProvider with ChangeNotifier {
  LocationData _location;
  Map<String, LatLng> _circleCenters = Map<String, LatLng>();
  AreaList _polygonsLatLngs;

  LocationData get getLocation => _location;
  Map<String, LatLng> get getCircle => _circleCenters;
  AreaList get getPolgons => _polygonsLatLngs;

  void setLocation(LocationData l) {
    _location = l;
    notifyListeners();
  }

  void addCircle(Map<String, LatLng> m) {
    _circleCenters.addAll(m);
    notifyListeners();
  }

  void setPolygonsLatLngs(AreaList s) {
    _polygonsLatLngs = s;
    notifyListeners();
  }

  bool _isInArea(List<LatLng> vertices) {
    LatLng cpos = LatLng(_location.latitude, _location.longitude);
    int intersectCount = 0;
    for (int j = 0; j < vertices.length - 1; j++) {
      if (rayCastIntersect(cpos, vertices[j], vertices[j + 1])) {
        intersectCount++;
      }
    }

    return ((intersectCount % 2) == 1);
  }

  bool rayCastIntersect(LatLng tap, LatLng vertA, LatLng vertB) {
    double aY = vertA.latitude;
    double bY = vertB.latitude;
    double aX = vertA.longitude;
    double bX = vertB.longitude;
    double pY = tap.latitude;
    double pX = tap.longitude;

    if ((aY > pY && bY > pY) || (aY < pY && bY < pY) || (aX < pX && bX < pX)) {
      return false;
    }

    double m = (aY - bY) / (aX - bX);
    double bee = (-aX) * m + aY;
    double x = (pY - bee) / m;

    return x > pX;
  }

  String findRegion() {
    for (var i = 0; i < _polygonsLatLngs.areas.length; i++) {
      for (var j = 0; j < _polygonsLatLngs.areas[i].latlng.length; j++) {
        List<LatLng> latLngs = [];
        for (var k = 0; k < _polygonsLatLngs.areas[i].latlng[j].length; k++) {
          double latitude = _polygonsLatLngs.areas[i].latlng[j][k][1];
          double longitude = _polygonsLatLngs.areas[i].latlng[j][k][0];
          latLngs.add(LatLng(latitude, longitude));
        }
        if (_isInArea(latLngs)) return _polygonsLatLngs.areas[i].location;
      }
    }
    return "None";
  }

  bool _isInCircle(LatLng centerPoint, double r) {
    LatLng cpos = LatLng(_location.latitude, _location.longitude);
    var ky = 40000 / 360;
    var kx = cos(pi * centerPoint.latitude / 180.0) * ky;
    var dx = (centerPoint.longitude - cpos.longitude).abs() * kx;
    var dy = (centerPoint.latitude - cpos.latitude).abs() * ky;
    return sqrt(dx * dx + dy * dy) <= r;
  }

  String findLocation() {
    String location = "None";
    _circleCenters.forEach((key, value) {
      if (_isInCircle(value, 0.1)) location = key;
    });
    return location;
  }
}
