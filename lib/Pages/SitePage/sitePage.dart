import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hackust_fakeust/Cards/siteCard.dart';
import 'package:hackust_fakeust/Components/categoryButton.dart';
import 'package:hackust_fakeust/Components/expandableText.dart';
import 'package:hackust_fakeust/Components/sitePageHeader.dart';

class SitePage extends StatelessWidget {
  final String country;
  final String site;
  final String description;

  const SitePage({Key key, @required this.country, this.site, this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(slivers: [
          SliverPersistentHeader(
            pinned: true,
            floating: false,
            delegate: SitePageHeader(
              minExtent: screenHeight * 0.21,
              maxExtent: screenHeight * 0.4,
              country: country,
              site: site,
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
                  child: SiteCard(),
                );
              },
              childCount: 10,
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(top: 50),
          ),
        ]),
      ),
    );
  }
}
