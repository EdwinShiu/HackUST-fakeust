import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CurrentUser extends ChangeNotifier {
  String _uid = 'B5aoQJ4bykgbdQ3THbvta2DXdWm2';
  String _username = 'testname';
  String _email = 'test@gmail.com';

  String get getUid => _uid;

  String get getEmail => _email;

  String get getUsername => _username;

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> signupUser(String email, String password) async {
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

        await FirebaseFirestore.instance
            .collection('users')
            .doc(_uid)
            .get()
            .then((querySnapshot) {
          _username = querySnapshot.data()['username'];
          print("$_username logged in");
        });

        notifyListeners();
      }
    } catch (e) {
      print(e);
    }

    return returnVal;
  }
}
