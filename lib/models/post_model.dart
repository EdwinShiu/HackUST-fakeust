import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String description;
  // ignore: non_constant_identifier_names
  String image_URL;
  String username;
  String location_name;
  String region_name;
  List<String> tags;

  String get getDescription => this.description;
  String get getImageURL => this.image_URL;
  List<String> get getTags => this.tags;

  PostModel({
    this.description,
    this.image_URL,
    this.username,
    this.location_name,
    this.region_name,
    this.tags,
  });
  factory PostModel.fromServerMap(Map data) {
    return PostModel(
      description: data['description'],
      location_name: data['location_name'],
      region_name: data['region_name'],
      image_URL: data['image_URL'],
      username: data['username'],
      tags: List<String>.from(data['tags']),
    );
  }
}

class PostsModel {
  Stream<List<PostModel>> stream;
  bool hasMore;

  Future<QuerySnapshot> querySnapshot;
  String last_create_date;
  bool _isLoading;
  int batchLength = 3;
  List<Map> _data;
  StreamController<List<Map>> _controller;

  PostsModel() {
    _data = [];
    _controller = StreamController<List<Map>>.broadcast();
    _isLoading = false;
    stream = _controller.stream.map((List<Map> postsData) {
      return postsData.map((Map postData) {
        return PostModel.fromServerMap(postData);
      }).toList();
    });
    hasMore = true;
    refresh();
  }

  Future<void> refresh() {
    return loadMore(clearCachedData: true);
  }

  Future<void> loadMore({bool clearCachedData = false}) {
    // initial load or refresh
    if (clearCachedData) {
      _data = [];
      hasMore = true;
      querySnapshot = FirebaseFirestore.instance
          .collection("posts")
          .orderBy("create_date", descending: true)
          .limit(batchLength)
          .get();
    } else {
      querySnapshot = FirebaseFirestore.instance
          .collection("posts")
          .orderBy("create_date", descending: true)
          .startAfter([last_create_date])
          .limit(batchLength)
          .get();
    }
    if (_isLoading || !hasMore) {
      return Future.value();
    }
    _isLoading = true;
    return querySnapshot.then((postsData) {
      if (postsData.docs.isEmpty) {
        hasMore = false;
      } else {
        _isLoading = false;

        hasMore = true;
        postsData.docs.forEach((postdata) {
          _data.add({
            'description': postdata['description'],
            'image_URL': postdata['image_URL'],
            'location_name': postdata['location_name'],
            'region_name': postdata['region_name'],
            'username': postdata['username'],
            'tags': postdata['tags'],
          });
        });
        last_create_date = postsData.docs.last['create_date'];
        _controller.add(_data);
      }
    });
  }
}
