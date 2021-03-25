import 'package:flutter/material.dart';

import './Constants/constants.dart';
import './Pages/StartUpPage/startupPage.dart';
import './Pages/SignInPage/signinPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StartupPage(),
      routes: {
        // '/': (context) => StartupPage(),
        '/signin': (context) => SigninPage(),
      },
    );
  }
}
