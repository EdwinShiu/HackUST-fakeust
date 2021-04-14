import 'package:flutter/material.dart';
import 'package:hackust_fakeust/Components/profile.dart';
import 'package:hackust_fakeust/Pages/errorPage.dart';
import 'package:hackust_fakeust/Pages/TravelLogPage/redeemPage.dart';

import 'newTravelLogPage.dart';

class MyPage extends StatefulWidget {
  @override
  MyPageState createState() => MyPageState();
}

class MyPageState extends State<MyPage> {
  int pageIndex = 0;

  void setPage(index) {
    setState(() {
      pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (pageIndex) {
      case 0:
        return Profile(setPage: setPage);
      case 1:
        return TravelLogPage(setPage: setPage);
      case 2:
        return RedeemPage(setPage: setPage);
      default:
        return ErrorPage();
    }
  }
}
