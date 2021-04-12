import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LeaderBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the height of the screen
    final screenHeight = MediaQuery.of(context).size.height;
    // Get the width of the screen
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: screenHeight * 0.15,
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Color(0xFF44CF73),
      ),
      child: Align(
        child: FutureBuilder<List<UserScore>>(
          future: _UserDatabase().userScoreList,
          builder: (context, snapshot) {
            // Get user score list
            List<UserScore> userScoreList = snapshot.data;
            // Sort user score list by score
            userScoreList.sort((a, b) => a.score.compareTo(b.score));
            return Padding(
              padding: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(userScoreList.length > 0
                              ? userScoreList[0]?.username
                              : '---'),
                        ),
                        Flexible(
                          child: Text(userScoreList.length > 0
                              ? userScoreList[0]?.score.toString()
                              : '---'),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(userScoreList[1]?.username ?? '---'),
                        ),
                        Flexible(
                          child:
                              Text(userScoreList[1]?.score.toString() ?? '---'),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(userScoreList[2]?.username ?? '---'),
                        ),
                        Flexible(
                          child:
                              Text(userScoreList[2]?.score.toString() ?? '---'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
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
