import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hackust_fakeust/Cards/siteCard.dart';
import 'package:hackust_fakeust/Components/sitePageHeader.dart';

class SitePage extends StatefulWidget {
  final String country;
  final String site;
  final String id;

  const SitePage({
    Key key,
    @required this.country,
    @required this.site,
    @required this.id,
  }) : super(key: key);

  @override
  _SitePageState createState() => _SitePageState();
}

class _SitePageState extends State<SitePage> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: GestureDetector(
              onHorizontalDragUpdate: (details) {
                int sensitivity = 8;
                if (details.delta.dx > sensitivity) {
                  Navigator.pop(context);
                }
              },
              child: CustomScrollView(slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  floating: false,
                  delegate: SitePageHeader(
                    minExtent: screenHeight * 0.21,
                    maxExtent: screenHeight * 0.4,
                    country: widget.country,
                    id: widget.id,
                    site: widget.site,
                    parent: this,
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.only(top: 20),
                ),
                SliverToBoxAdapter(
                  child: FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection("posts")
                        .where('${widget.site}_id', isEqualTo: widget.id)
                        .get(),
                    builder: (context, snapshot) {
                      return snapshot.connectionState == ConnectionState.done &&
                              snapshot.data != null
                          ? Container(
                              height: screenHeight * 0.5,
                              child: ListView.builder(
                                itemCount: snapshot.data.docs.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SiteCard(
                                      username: snapshot.data.docs[index]
                                          ['username'],
                                      caption: snapshot.data.docs[index]
                                          ['description'],
                                      date: snapshot.data.docs[index]
                                          ['create_date'],
                                      imageUrl: snapshot.data.docs[index]
                                          ['image_URL'],
                                    ),
                                  );
                                },
                              ),
                            )
                          : Center(
                              child: Text(
                                "No Post Yet",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black,
                                ),
                              ),
                            );
                    },
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.only(top: 50),
                ),
              ])),
        ),
      ),
    );
  }
}
