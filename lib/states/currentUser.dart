import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:location/location.dart';

class CurrentUser extends ChangeNotifier {
  String _uid = 'B5aoQJ4bykgbdQ3THbvta2DXdWm2';
  String _email = 'test@gmail.com';
  String _username = 'testname';
  LocationData _location;
  String _locationName = "other";
  String _regionName = "other";
  String _locationId = "0";
  String _regionId = "0";

  String get getUid => _uid;

  String get getEmail => _email;

  String get getUsername => _username;

  LocationData get getLocation => _location;

  String get getLocationId => _locationId;

  String get getLocationName => _locationName;

  String get getRegionId => _regionId;

  String get getRegionName => _regionName;

  void updateLocationId(String locationId) {
    _locationId = locationId;
  }

  void updateRegionId(String regionId) {
    _regionId = regionId;
  }

  void updateLocation(LocationData newLocation) {
    _location = newLocation;
  }

  void updateLocationName(String name) {
    _locationName = name;
  }

  void updateRegionName(String name) {
    _regionName = name;
  }

  CurrentUser();

  // ignore: non_constant_identifier_names
  CurrentUser.reg(User user, String username) {
    _uid = user.uid;
    _username = username;
    _email = user.email;
  }

  FirebaseAuth _auth = FirebaseAuth.instance;

  // ignore: non_constant_identifier_names
  CurrentUser _UserFromFirebaseUser(User user, String username) {
    return user != null ? CurrentUser.reg(user, username) : null;
  }

  // Register with new account
  // ignore: non_constant_identifier_names
  Future RegisterWithEmailAndPW(
      String email, String password, String username) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _UserFromFirebaseUser(user, username);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<bool> signinUser(String email, String password) async {
    bool returnVal = false;

    try {
      UserCredential _authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (_authResult.user != null) {
        _uid = _authResult.user.uid;
        _email = _authResult.user.email;
        returnVal = true;
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }

    return returnVal;
  }

  Future<void> signOutUser() async {
    try {
      await _auth.signOut();
      print('signout');
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
