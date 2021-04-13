import 'package:flutter/material.dart';
import 'package:hackust_fakeust/Pages/SocialMediaPage/UploadPost.dart';
import 'package:hackust_fakeust/Pages/TravelLogPage/newTravelLogPage.dart';
import 'package:hackust_fakeust/states/currentUser.dart';
import 'package:provider/provider.dart';
import 'package:hackust_fakeust/Components/mapWidget.dart';
import 'package:hackust_fakeust/Pages/SocialMediaPage/SocialMediaPage.dart';
import 'package:hackust_fakeust/Pages/TravelLogPage/travellogpage.dart';
import 'package:hackust_fakeust/Pages/mapPage/mapPage.dart';
import 'package:hackust_fakeust/models/new_post.dart';

import '../../Cards/travellogCard.dart';
import '../LeaderboardPage/LeaderboardPage.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPage createState() => _LandingPage();
}

class _LandingPage extends State<LandingPage> {
  int _currentIndex = 0;
  final List<Widget> stay_alive_screens = [
    MapPage(),
    //SocialMediaPage(),
    Container(child: Text("s")),
    LeaderBoardPage(),
    TravelLogPage()
  ];

  void addPost(String uid) {
    print("UPLOAD POST");
    NewPost _newPost = Provider.of<NewPost>(context, listen: false);
    _newPost.initTags();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UploadPost(),
      ),
    );
  }

  void onTabTapped(int index) {
    print("GO TO page $index");
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    String uid = Provider.of<CurrentUser>(context).getUid;

    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: IndexedStack(
            index: _currentIndex,
            children: stay_alive_screens,
          ),
          floatingActionButton: FloatingActionButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            onPressed: () => addPost(uid),
            child: Icon(Icons.add),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
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
