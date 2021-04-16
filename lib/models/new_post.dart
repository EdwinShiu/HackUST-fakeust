import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewPost extends ChangeNotifier {
  List<String> tagsSelected = [];
  List<String> tags = [];
  var location;
  String description;
  var imagePath;
  var imageUrl;

  // fetch from database to get tags
  NewPost() {
    initTags();
  }

  initTags() async {
    tags = [];
    tagsSelected = [];
    int length;
    await FirebaseFirestore.instance
        .collection('tags')
        .get()
        .then((querySnapshot) async {
      length = querySnapshot.docs.length;
    });

    for (int i = 0; i < length; i++) {
      String ttag;
      await FirebaseFirestore.instance
          .collection('tags')
          .doc('$i')
          .get()
          .catchError((onError) {})
          .then((_querySnapshot) {
        ttag = _querySnapshot.data()['tag'].toString();
      });
      //FIREBASE PEOPLE FIX THE FREAKING BUG PLEASE
      if (tags.isEmpty || tags.last != ttag) {
        tags.add(ttag);
      }
    }
  }

  onTagSelect(int i) {
    tagsSelected.contains(this.tags[i])
        ? this.tagsSelected.remove(this.tags[i])
        : this.tagsSelected.add(this.tags[i]);
  }

  List<String> getTags() => this.tags;

  List<String> getTagsSelected() => this.tagsSelected;

  String getDescription() => this.description;

  getimagePath() => this.imagePath;

  getimageUrl() => this.imageUrl;

  void setDescription(String des) {
    this.description = des;
  }

  void setImagePath(var imagePath) {
    this.imagePath = imagePath;
  }

  void setImageUrl(var imageUrl) {
    this.imageUrl = imageUrl;
  }
}
