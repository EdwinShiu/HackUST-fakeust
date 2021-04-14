import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hackust_fakeust/Cards/siteCard.dart';
import 'package:hackust_fakeust/Components/sitePageHeader.dart';

class SitePage extends StatelessWidget {
  final String country;
  final String region;
  final String rid;
  final String description;

  const SitePage(
      {Key key,
      @required this.country,
      this.region,
      this.rid,
      this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection("posts")
                .where('region_id', isEqualTo: rid)
                .get(),
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.done
                  ? CustomScrollView(slivers: [
                      SliverPersistentHeader(
                        pinned: true,
                        floating: false,
                        delegate: SitePageHeader(
                          minExtent: screenHeight * 0.21,
                          maxExtent: screenHeight * 0.4,
                          country: country,
                          site: region,
                          description: description,
                        ),
                      ),
                      SliverPadding(
                        padding: EdgeInsets.only(top: 20),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SiteCard(
                                username: snapshot.data.docs[index]['username'],
                                caption: snapshot.data.docs[index]
                                    ['description'],
                                date: snapshot.data.docs[index]['create_date'],
                                imageUrl: snapshot.data.docs[index]
                                    ['image_URL'],
                              ),
                            );
                          },
                          childCount: snapshot.data.docs.length,
                        ),
                      ),
                      SliverPadding(
                        padding: EdgeInsets.only(top: 50),
                      ),
                    ])
                  : Container();
            }),
      ),
    );
  }
}
