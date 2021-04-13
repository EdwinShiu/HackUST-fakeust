import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:location/location.dart';

class USER {
  final String uid;
  USER({this.uid});
}

class CurrentUser extends ChangeNotifier {
  String _uid = 'B5aoQJ4bykgbdQ3THbvta2DXdWm2';
  String _username = 'testname';
  String _email = 'test@gmail.com';
  LocationData _location;

  String get getUid => _uid;

  String get getEmail => _email;

  String get getUsername => _username;

  LocationData get getLocation => _location;

  FirebaseAuth _auth = FirebaseAuth.instance;

/*  Future<bool> signupUser(String email, String password) async {
    bool returnVal = false;

    try {
      UserCredential _authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (_authResult.user != null) {
        returnVal = true;
      }
    } catch (e) {
      print(e);
    }

    return returnVal;
  } */

  void updateLocation(LocationData newLocation) {
    _location = newLocation;
  }

  // ignore: non_constant_identifier_names
  USER _UserFromFirebaseUser(User user) {
    return user != null ? USER(uid: user.uid) : null;
  }

  // Register with new account
  // ignore: non_constant_identifier_names
  Future RegisterWithEmailAndPW(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _UserFromFirebaseUser(user);
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
}
