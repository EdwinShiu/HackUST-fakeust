import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hackust_fakeust/states/currentUser.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loading_animations/loading_animations.dart';

class RedeemPage extends StatelessWidget {
  RedeemPage({Key key, this.setPage}) : super(key: key);

  final ValueSetter<int> setPage;

  final List discountList = [
    {'name': 'Discount 1', 'point': 20},
    {'name': 'Discount 2', 'point': 90},
    {'name': 'Discount 3', 'point': 15},
    {'name': 'Discount 4', 'point': 40}
  ];

  Future<void> _showDialog(context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Text('Work In Progress'),
            ),
            titleTextStyle: Theme.of(context).textTheme.headline2,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // Get the height of the screen
    final screenHeight = MediaQuery.of(context).size.height;
    // Get the width of the screen
    final screenWidth = MediaQuery.of(context).size.width;

    CurrentUser _currentUser = Provider.of<CurrentUser>(context);
    String uid = _currentUser.getUid;

    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: screenHeight * 0.06,
            width: double.infinity,
            child: Stack(
              children: [
                Center(
                  child: Text(
                    "Redeem",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.06,
                  width: screenHeight * 0.06,
                  child: TextButton(
                    onPressed: () {
                      setPage(0);
                    },
                    child: Icon(
                      FontAwesomeIcons.chevronLeft,
                      color: Color(0xFF1e1e1e),
                    ),
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.8),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 3),
                ),
              ],
            ),
          ),
          Container(
            height: screenHeight * 0.25,
            padding: EdgeInsets.only(left: 5, bottom: 5),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Row(
                children: [
                  Text(
                    'Your Points: ',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  FutureBuilder<DocumentSnapshot>(
                    future: FirebaseFirestore.instance
                        .collection('users')
                        .doc(uid)
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return SizedBox(
                          height: 32,
                          width: 32,
                          child: Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: LoadingRotating.square(
                              duration: Duration(milliseconds: 500),
                            ),
                          ),
                        );
                      }
                      return Text(
                        '${snapshot.data?.data()['point']}',
                        style: Theme.of(context).textTheme.headline1,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              color: Color(0xFFA0DAE8),
              child: ListView.builder(
                itemCount: discountList.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 140,
                    width: double.maxFinite,
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                    decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x33333333),
                          offset: Offset(0, 3),
                          spreadRadius: 1,
                          blurRadius: 3,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                discountList[index]['name'],
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(fontSize: 26),
                              ),
                              SizedBox(height: 10),
                              Text(
                                  'Point: ' +
                                      discountList[index]['point'].toString(),
                                  style: Theme.of(context).textTheme.bodyText1),
                            ],
                          ),
                        ),
                        Container(
                          width: double.maxFinite,
                          child: OutlinedButton(
                            style: ButtonStyle(
                              side: MaterialStateProperty.all<BorderSide>(
                                  BorderSide(
                                color: Colors.blue,
                              )),
                            ),
                            onPressed: () {
                              _showDialog(context);
                            },
                            child: Text(
                              'Redeem',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(color: Colors.blue),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
