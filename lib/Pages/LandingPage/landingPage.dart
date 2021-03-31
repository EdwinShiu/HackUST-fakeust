import 'package:flutter/material.dart';

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
      type: BottomNavigationBarType.shifting,
      currentIndex: _selectedIndex,
      onTap: _onTapChangeIndex,
      items: [
        BottomNavigationBarItem(
          backgroundColor: Colors.green,
          icon: Icon(
            Icons.explore,
          ),
          label: 'Map',
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.blue,
          icon: Icon(
            Icons.search,
          ),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.red,
          icon: Icon(
            Icons.content_paste,
          ),
          label: 'Leaderboard',
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.yellow,
          icon: Icon(
            Icons.book,
          ),
          label: 'Travel Log',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: bottomNavigationBar(),
        body: Container(
          child: PageView(
            controller: _pageController,
            children: [
              Stack(
                children: [
                  Center(
                    child: Text('Page1'),
                  ),
                ],
              ),
              Center(
                child: Text('Page2'),
              ),
              Center(
                child: Text('Page3'),
              ),
              Center(
                child: LogCard(
                  title: widget.titlefromDb,
                  caption: widget.captionfromDb,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
