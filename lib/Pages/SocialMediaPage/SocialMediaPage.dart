import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Constants/constants.dart';
import '../../states/currentUser.dart';
import '../../Components/post.dart';
import './UploadPost.dart';
import '../../models/new_post.dart';

class SocialMediaPage extends StatefulWidget {
  // const SocialPage({Key? key}) : super(key: key);

  @override
  _SocialMediaPage createState() => _SocialMediaPage();
}

class _SocialMediaPage extends State<SocialMediaPage> {
  bool addingPost = false;
  @override
  void initState() {
    super.initState();
  }

  void addPost(String uid) {
    print("UPLOAD POST");
    NewPost _newPost = Provider.of<NewPost>(context, listen: false);
    _newPost.initTags();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UploadPost(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // var screenHeight = MediaQuery.of(context).size.height;
    // var screenWidth = MediaQuery.of(context).size.width;
    String uid = Provider.of<CurrentUser>(context).getUid;
    var post;
    return Stack(
      children: [
        StreamBuilder(
          stream: FirebaseFirestore.instance.collection('posts').snapshots(),
          builder: (context, snapshot) {
            // post = snapshot.data.docs;
            if (!snapshot.hasData)
              return Text("NO POST");
            else
              return CustomScrollView(slivers: <Widget>[
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      print("NUM of POSTS ${snapshot.data.docs.length}");
                      post =
                          snapshot.data.docs[index % snapshot.data.docs.length];
                      // may need to sort posts
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

                          if (snapshot.connectionState ==
                              ConnectionState.done) {
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
        ),
        // add post
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 15.0, bottom: 15.0),
            child: FloatingActionButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              onPressed: () => addPost(uid),
              child: Icon(Icons.add),
            ),
          ),
        ),
      ],
    );
  }
}
