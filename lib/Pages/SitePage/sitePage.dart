import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hackust_fakeust/Components/categoryButton.dart';
import 'package:hackust_fakeust/Components/expandableText.dart';

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
    print(country);
    return Material(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: screenHeight * 0.3,
              width: screenWidth,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/logCard2.jpeg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: List.generate(3, (int index) => CategoryButton()),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    country ?? "Country",
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 20,
                        color: Colors.black),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    site ?? "Site",
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 40,
                        color: Colors.black),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ExpandableText(
                    text: description ?? "description",
                    maxLines: 20,
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 15,
                        color: Colors.black),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                ),
                Container(
                    height: screenHeight * 0.6,
                    child: ListView(
                        padding: const EdgeInsets.all(8),
                        children: List.generate(
                            10,
                            (index) => Container(
                                height: 100,
                                color: Color((Random().nextDouble() * 0xFFFFFF)
                                        .toInt())
                                    .withOpacity(0.5)))))
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
