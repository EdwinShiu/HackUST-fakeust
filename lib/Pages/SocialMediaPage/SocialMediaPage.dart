import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var screenHeight = MediaQuery.of(context).size.height;
    // var screenWidth = MediaQuery.of(context).size.width;
    // var uid = Provider.of<CurrentUser>(context).getUid;

    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('posts').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Text("NO POST");
        else
          return CustomScrollView(slivers: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final post =
                      snapshot.data.docs[index % snapshot.data.docs.length];
                  //get username by uid
                  return FutureBuilder<DocumentSnapshot>(
                    future: FirebaseFirestore.instance
                        .collection('users')
                        .doc(post['uid'])
                        .get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Post();
                      }

                      if (snapshot.connectionState == ConnectionState.done) {
                        Map<String, dynamic> data = snapshot.data.data();
                        if (data != null)
                          return Post(
                            username: data['username'],
                            imageURL: post['image_URL'],
                            likeCount: post['like_count'],
                            caption: post['description'],
                          );
                      }
                      return Post();
                    },
                  );
                },
              ),
            ),
          ]);
      },
    );
  }
}
