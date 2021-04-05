import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Constants/constants.dart';
import '../../states/currentUser.dart';
import '../../Cards/travellogCard.dart';
import '../../Components/post.dart';

class SocialMediaPage extends StatefulWidget {
  // const SocialPage({Key? key}) : super(key: key);

  @override
  _SocialMediaPage createState() => _SocialMediaPage();
}

class _SocialMediaPage extends State<SocialMediaPage> {
  // List<int> posts = <int>[];

  @override
  Widget build(BuildContext context) {
    // var screenHeight = MediaQuery.of(context).size.height;
    // var screenWidth = MediaQuery.of(context).size.width;
    // var uid = Provider.of<CurrentUser>(context).getUid;

    return CustomScrollView(slivers: <Widget>[
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Container(
              alignment: Alignment.center,
              child: Post(),
            );
          },
          childCount: 10,
        ),
      ),
    ]);
  }
}
