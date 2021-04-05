import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import './Constants/constants.dart';
import './Pages/StartUpPage/startupPage.dart';
import './Pages/LandingPage/landingPage.dart';
import './Pages/SignInPage/signinPage.dart';
import './states/currentUser.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CurrentUser()),
      ],
      child: MaterialApp(
        title: appTitle,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LandingPage(),
        routes: {
          '/signin': (context) => SigninPage(),
          '/landing': (context) => LandingPage(),
        },
      ),
    );
  }
}
