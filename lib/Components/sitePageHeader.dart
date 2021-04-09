import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hackust_fakeust/Components/categoryButton.dart';
import 'package:hackust_fakeust/Components/expandableText.dart';
import 'package:hackust_fakeust/Components/siteDescriptionDialog.dart';

class SitePageHeader extends SliverPersistentHeaderDelegate {
  SitePageHeader(
      {this.minExtent,
      this.maxExtent,
      this.country,
      this.site,
      this.description});

  final double minExtent;
  final double maxExtent;
  final String country;
  final String site;
  final String description;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    overlapsContent = false;
    print(shrinkOffset);
    return Column(
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
        Container(
          color: Colors.white,
          child: Column(
            children: [
              Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      country ?? "Country",
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 20,
                          color: Colors.black),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: List.generate(3, (int index) => CategoryButton()),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        // padding: EdgeInsets.symmetric(vertical: 10.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          site ?? "Site",
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 40,
                              color: Colors.black),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.info_outline),
                        onPressed: () => showDialog(
                            context: context,
                            builder: (context) {
                              return SiteDescriptionDialog(
                                site: site,
                                description: description,
                              );
                            }),
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
