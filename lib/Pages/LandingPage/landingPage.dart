import 'package:flutter/material.dart';
import 'package:hackust_fakeust/Components/mapWidget.dart';
import 'package:hackust_fakeust/Pages/SocialMediaPage/SocialMediaPage.dart';
import 'package:hackust_fakeust/Pages/TravelLogPage/travellogpage.dart';

import '../../Cards/travellogCard.dart';
import '../LeaderboardPage/LeaderboardPage.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPage createState() => _LandingPage();
}

class _LandingPage extends State<LandingPage> {
  int _currentIndex = 1;
  final List<Widget> stay_alive_screens = [
    MapWidget(),
    SocialMediaPage(),
    LeaderBoardPage(),
    TravelLogPage()
  ];

  void onTabTapped(int index) {
    print("GO TO page $index");
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: IndexedStack(
            index: _currentIndex,
            children: stay_alive_screens,
          ),
          bottomNavigationBar: BottomNavigationBar(
            elevation: 0,
            fixedColor: Colors.black,
            type: BottomNavigationBarType.fixed,
            onTap: onTabTapped,
            currentIndex: _currentIndex,
            items: [
              BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: Icon(
                  Icons.explore,
                  color: Colors.blue,
                ),
                label: 'Map',
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: Icon(
                  // color: Colors.blue,
                  Icons.search,
                  color: Colors.blue,
                ),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: Icon(
                  Icons.content_paste,
                  color: Colors.blue,
                ),
                label: 'Leaderboard',
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: Icon(
                  Icons.book,
                  color: Colors.blue,
                ),
                label: 'Travel Log',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
