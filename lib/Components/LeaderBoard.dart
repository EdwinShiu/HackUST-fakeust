import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animations/loading_animations.dart';
import 'dart:math';

class LeaderBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the height of the screen
    final screenHeight = MediaQuery.of(context).size.height;
    // Get the width of the screen
    final screenWidth = MediaQuery.of(context).size.width;

    Future<void> _handleClickMe(List<UserScore> userScoreList) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.all(10),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: screenWidth * 0.9,
                    height: screenHeight * 0.8,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFFFFFFFF)),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(
                          'LeaderBoard',
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        Divider(
                          indent: 20,
                          endIndent: 20,
                          height: 3,
                          color: Color(0xAA666666),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount:
                                min(userScoreList.length, 100), // Show top 100
                            itemBuilder: (context, index) {
                              return Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: Center(
                                      child: Text(
                                        (index + 1).toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      userScoreList[index]
                                          ?.username
                                          ?.toString(),
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 80,
                                    height: 40,
                                    child: Center(
                                      child: Text(
                                        userScoreList[index]?.score?.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ));
        },
      );
    }

    return Container(
      height: screenHeight * 0.15,
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Color(0xFF44CF73),
      ),
      child: FutureBuilder<List<UserScore>>(
        future: _UserDatabase().userScoreList,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return LoadingRotating.square(
              duration: Duration(milliseconds: 500),
            );
          } else {
            // Get user score list
            List<UserScore> userScoreList = snapshot.data;
            // Sort user score list by score
            userScoreList.sort((a, b) => b.score.compareTo(a.score));
            return InkWell(
              onTap: () {
                _handleClickMe(userScoreList);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Icon(
                              FontAwesomeIcons.trophy,
                              color: Color(0xFFF5C938),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              userScoreList.length > 0
                                  ? userScoreList[0]?.username
                                  : '---',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                          Container(
                            width: 50,
                            child: Text(
                              userScoreList.length > 0
                                  ? userScoreList[0]?.score.toString()
                                  : '---',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Icon(
                              FontAwesomeIcons.trophy,
                              color: Color(0xFFD9D9D9),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              userScoreList[1]?.username ?? '---',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                          Container(
                            width: 50,
                            child: Text(
                              userScoreList[1]?.score.toString() ?? '---',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Icon(
                              FontAwesomeIcons.trophy,
                              color: Color(0xFFC79540),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              userScoreList[2]?.username ?? '---',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                          Container(
                            width: 50,
                            child: Text(
                              userScoreList[2]?.score.toString() ?? '---',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

// Class to fetch user score
class _UserDatabase {
  // Collection Reference for fetching user data
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  // Map List<Snapshot> to List<UserScore>
  Future<List<UserScore>> get userScoreList async {
    return List<UserScore>.from((await _userCollectionData()).docs.map((doc) {
      return UserScore(
        username: doc.data()['username'] ?? '---', // null-aware
        score: doc.data()['score'] ?? -1, // null-aware
      );
    }));
  }

  // private method that fetch users collection in firestore
  Future<QuerySnapshot> _userCollectionData() async {
    return await userCollection.get();
  }
}

// Class for List structure
class UserScore {
  String username;
  int score;

  UserScore({@required this.username, @required this.score});
}
