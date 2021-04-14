import 'package:flutter/material.dart';
import 'package:hackust_fakeust/Cards/travellogCard.dart';
import 'package:hackust_fakeust/states/currentUser.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TravelLogPage extends StatelessWidget {
  TravelLogPage({Key key, this.setPage}) : super(key: key);

  final ValueSetter<int> setPage;

  @override
  Widget build(BuildContext context) {
    String uid = Provider.of<CurrentUser>(context).getUid;
    return Material(
      child: Container(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.06,
              width: double.infinity,
              child: Stack(
                children: [
                  Center(
                    child: Text(
                      "Travel Log",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.height * 0.06,
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
            Expanded(
              child: FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection("posts")
                    .where('uid', isEqualTo: uid)
                    .get(),
                builder: (context, snapshot) {
                  // for (var doc in snapshot.data.docs) print(doc['description']);
                  if (snapshot.connectionState != ConnectionState.done) {
                    return LoadingRotating.square(
                      duration: Duration(milliseconds: 500),
                    );
                  }
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: ListView(
                      children: List.generate(
                        snapshot.data.docs.length,
                        (index) => TimelineTile(
                          beforeLineStyle: LineStyle(
                            color: Colors.blue,
                            thickness: 6,
                          ),
                          afterLineStyle: LineStyle(
                            color: Colors.blue,
                            thickness: 6,
                          ),
                          indicatorStyle: IndicatorStyle(
                            width: 25,
                            indicator: Container(
                              decoration: new BoxDecoration(
                                border: Border.all(
                                  color: Colors.blue,
                                  width: 3,
                                ),
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          alignment: TimelineAlign.start,
                          lineXY: 0.05,
                          endChild: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TravelLogCard(
                              locationName: snapshot.data.docs[index]
                                  ['location_name'],
                              description: snapshot.data.docs[index]
                                  ['description'],
                              imageUrl: snapshot.data.docs[index]['image_URL'],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
