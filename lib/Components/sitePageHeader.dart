import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hackust_fakeust/Components/addTagDialog.dart';
import 'package:hackust_fakeust/Components/categoryButton.dart';
import 'package:hackust_fakeust/Components/siteDescriptionDialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hackust_fakeust/Pages/SitePage/sitePage.dart';

class SitePageHeader extends SliverPersistentHeaderDelegate {
  SitePageHeader(
      {this.minExtent,
      this.maxExtent,
      this.country,
      this.id,
      this.site,
      this.description,
      this.parent});

  final double minExtent;
  final double maxExtent;
  final String country;
  final String id;
  final String site;
  final String description;
  final State<SitePage> parent;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    overlapsContent = false;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.8),
            spreadRadius: 1,
            blurRadius: 20,
            offset: Offset(0, -10),
          ),
        ],
      ),
      child: Column(
        children: [
          Flexible(
            child: Container(
              child: Image.asset(
                "assets/images/logCard2.jpeg",
                height: MediaQuery.of(context).size.height * 0.3,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          FutureBuilder(
            future: FirebaseFirestore.instance
                .collection("${site}s")
                .where('${site[0]}id', isEqualTo: id)
                .get()
                .then((snapshot) => snapshot.docs[0]),
            builder: (context, snapshot) {
              return Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: List.generate(
                          snapshot.data != null
                              ? snapshot.data['tags'] == null
                                  ? 0
                                  : snapshot.data['tags'].length > 3
                                      ? 3
                                      : snapshot.data['tags'].length
                              : 0,
                          (int index) => snapshot.data['tags'][index] != ""
                              ? CategoryButton(
                                  text: snapshot.data['tags'][index],
                                  enabled: false,
                                )
                              : Container())
                        ..add(
                          RawMaterialButton(
                            onPressed: () => showDialog(
                              context: context,
                              builder: (context) {
                                return AddTagDialog(
                                  id: id,
                                  site: site,
                                  list: snapshot.data['tags'],
                                  parent: parent,
                                );
                              },
                            ),
                            elevation: 2.0,
                            fillColor: Colors.blue[300],
                            child: Icon(
                              Icons.add,
                              size: 30.0,
                            ),
                            padding: EdgeInsets.all(5.0),
                            shape: CircleBorder(),
                            constraints: BoxConstraints.expand(
                                height: 40.0, width: 40.0),
                          ),
                        ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        country ?? "Country",
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 20,
                            color: Colors.black),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: AutoSizeText(
                                snapshot.data == null
                                    ? site
                                    : snapshot.data['${site}_name'],
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontSize: 40,
                                    color: Colors.black),
                                maxLines: 1,
                              ),
                            ),
                            IconButton(
                                icon: Icon(Icons.info_outline),
                                onPressed: () => showDialog(
                                    context: context,
                                    builder: (context) {
                                      return SiteDescriptionDialog(
                                        site: snapshot.data['${site}_name'],
                                        description: description,
                                      );
                                    })),
                          ]),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
