import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '../../Constants/constants.dart';
import '../../states/currentUser.dart';
import '../../Components/post.dart';
import './UploadPost.dart';
import '../../models/new_post.dart';
import '../../models/post_model.dart';

class SocialMediaPage extends StatefulWidget {
  // const SocialPage({Key? key}) : super(key: key);

  @override
  _SocialMediaPage createState() => _SocialMediaPage();
}

class _SocialMediaPage extends State<SocialMediaPage> {
  bool addingPost = false;

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

  final scrollController = ScrollController();
  PostsModel posts;

  @override
  void initState() {
    posts = PostsModel();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        posts.loadMore();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var screenHeight = MediaQuery.of(context).size.height;
    // var screenWidth = MediaQuery.of(context).size.width;
    String uid = Provider.of<CurrentUser>(context).getUid;

    return Stack(
      children: [
        StreamBuilder(
          stream: posts.stream,
          builder: (BuildContext _context, AsyncSnapshot _snapshot) {
            if (!_snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              print("POSTS NUM: ${_snapshot.data.length}");
              return RefreshIndicator(
                onRefresh: posts.refresh,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  controller: scrollController,
                  itemCount: _snapshot.data.length + 1,
                  itemBuilder: (BuildContext _context, int index) {
                    if (index < _snapshot.data.length) {
                      return Post(post: _snapshot.data[index]);
                    } else if (posts.hasMore) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 0),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    } else {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 32.0),
                        child: Center(child: Text('nothing more to load!')),
                      );
                    }
                  },
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
