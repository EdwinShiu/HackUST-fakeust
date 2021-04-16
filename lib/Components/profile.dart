import 'package:flutter/material.dart';
import 'package:hackust_fakeust/states/currentUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animations/loading_animations.dart';

class Profile extends StatelessWidget {
  Profile({Key key, this.setPage}) : super(key: key);

  final ValueSetter<int> setPage;

  @override
  Widget build(BuildContext context) {
    // Get the height of the screen
    final screenHeight = MediaQuery.of(context).size.height;
    // Get the width of the screen
    final screenWidth = MediaQuery.of(context).size.width;

    CurrentUser _currentUser = Provider.of<CurrentUser>(context);
    String uid = _currentUser.getUid;
    return Container(
      height: screenHeight,
      width: screenWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: screenHeight * 0.1),
          Text(
            'My Page',
            style: Theme.of(context).textTheme.headline1,
          ),
          SizedBox(height: screenHeight * 0.05),
          Icon(
            FontAwesomeIcons.userCircle,
            size: screenHeight * 0.2,
            color: Color(0xFFA0DAE8),
          ),
          Container(
            height: screenHeight * 0.1,
            child: Center(
              child: FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(uid)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return LoadingRotating.square(
                      duration: Duration(milliseconds: 500),
                    );
                  }
                  return Text(
                    'Score: ${snapshot.data?.data()['score']}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontSize: 22),
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.06,
            width: screenWidth * 0.5,
            child: TextButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xFFA0DAE8)),
              ),
              onPressed: () {
                setPage(1);
              },
              child: Text(
                'Travel Log',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontSize: 20),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          SizedBox(
            height: screenHeight * 0.06,
            width: screenWidth * 0.5,
            child: TextButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xFFA0DAE8)),
              ),
              onPressed: () {
                setPage(2);
              },
              child: Text(
                'Redeem',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontSize: 20),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          SizedBox(
            height: screenHeight * 0.06,
            width: screenWidth * 0.5,
            child: TextButton(
              onPressed: () async {
                await _currentUser.signOutUser();
                Navigator.popAndPushNamed(context, '/signin');
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xFFA0DAE8)),
              ),
              child: Text(
                'Sign Out',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
