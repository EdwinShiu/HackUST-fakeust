import 'package:flutter/material.dart';
import 'package:hackust_fakeust/Components/mapWidget.dart';
import 'package:hackust_fakeust/Pages/SocialMediaPage/SocialMediaPage.dart';
import 'package:hackust_fakeust/Pages/TravelLogPage/travellogpage.dart';

import '../../Cards/travellogCard.dart';

class LandingPage extends StatefulWidget {
  final String titlefromDb = 'TITLE from Db';
  final String captionfromDb =
      'Caption from database aaaaaaaa aa aaaaaaaaaaaa aaaa aaaaa aa aaaaaaaa aaaaa';
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  PageController _pageController = PageController();
  int _selectedIndex = 0;

  void _onTapChangeIndex(int index) {
    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 500), curve: Curves.easeInOutCubic);
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget bottomNavigationBar() {
    return BottomNavigationBar(
      elevation: 0,
      type: BottomNavigationBarType.shifting,
      currentIndex: _selectedIndex,
      onTap: _onTapChangeIndex,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: bottomNavigationBar(),
          body: Container(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Container(
                  child: MapWidget(),
                ),
                Container(
                  child: SocialMediaPage(),
                ),
                Center(
                  child: Text('Page3'),
                ),
                Center(
                  // child: LogCard(
                  //   title: widget.titlefromDb,
                  //   caption: widget.captionfromDb,
                  // ),
                  child: TravelLogPage(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
