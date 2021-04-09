import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../../states/currentUser.dart';
import '../../models/new_post.dart';
import "../../Constants/constants.dart";
import "../../Components/categoryButton.dart";
import '../../Components/post.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UploadPost extends StatefulWidget {
  @override
  _UploadPost createState() => _UploadPost();
}

class _UploadPost extends State<UploadPost> {
  var imagePath;
  // bool inputCaption = false;
  TextEditingController _description = TextEditingController();

  // List<UploadJob> _profilePictures = [];

  selectImage() async {
    final _picker = ImagePicker();
    PickedFile image;

    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select Image
      image = await _picker.getImage(source: ImageSource.gallery);

      if (image != null) {
        print("photos selected");
        setState(() {
          imagePath = File(image.path);
        });
      } else {
        print('No image Received');
      }
    } else {
      print('Grant Permissions and try again');
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    String uid = Provider.of<CurrentUser>(context).getUid;
    NewPost _newPost = Provider.of<NewPost>(context, listen: false);
    List<bool> tagsSelected = _newPost.getTagsSelected();

    print("UPLOAD PAGER BUILT");
    // FocusScope.of(context).unfocus();

    print("upload post page built");
    return Container(
      color: Colors.teal[50],
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.teal[50],
          body: SingleChildScrollView(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Container(
                // height: screenHeight * 0.9,
                // color: Colors.teal[50],
                child: Column(
                  children: [
                    // top info bar
                    Container(
                      height: screenHeight * 0.05,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Select Photo",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          (imagePath == null)
                              ? Container()
                              : Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: TextButton(
                                      onPressed: () {
                                        // _description
                                        _newPost
                                            .setDescription(_description.text);
                                        _newPost.setImagePath(this.imagePath);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => PreviewPost(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        "Preview",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.teal),
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                    (imagePath == null)
                        ? Container(
                            height: screenHeight * postArea,
                            width: screenWidth,
                            color: Colors.grey[300],
                            // alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.only(top: screenHeight * 0.2),
                              child: Container(
                                child: Column(
                                  children: [
                                    Text(
                                      "Upload Image from Gallery",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: FloatingActionButton(
                                        onPressed: () => selectImage(),
                                        child: Icon(Icons.photo),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Container(
                            height: screenHeight * postArea,
                            // image background
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: FileImage(imagePath),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                    // chose image then display additional info
                    (imagePath == null)
                        ? Container()
                        : Container(
                            height: screenHeight * 0.05,
                            color: Colors.teal[50],
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10.0, right: 20),
                                    child: SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: FloatingActionButton(
                                        onPressed: () => selectImage(),
                                        child: Icon(Icons.photo),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10.0, right: 75),
                                    child: Container(
                                      height: 50,
                                      width: 55,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Another Photo",
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, left: 10),
                                    child: Text(
                                      "Description",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                    (imagePath == null)
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            child: TextFormField(
                              autocorrect: false,
                              controller: _description,
                              minLines: 2,
                              maxLines: 3,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Anything you want to say?',
                                  hintText: 'This is beautiful!'),
                            ),
                          ),
                    (imagePath == null)
                        ? Container()
                        : Container(
                            height: screenHeight * 0.05,
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  "Add some Tags!",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            )),
                    (imagePath == null)
                        ? Container()
                        : Container(
                            height: 40,
                            child: TagsScrollView(),
                          )
                    //ff
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TagsScrollView extends StatefulWidget {
  @override
  _TagsScrollView createState() => _TagsScrollView();
}

class _TagsScrollView extends State<TagsScrollView> {
  @override
  Widget build(BuildContext context) {
    NewPost _newPost = Provider.of<NewPost>(context, listen: false);
    var tagsSelected =
        context.select<NewPost, List<bool>>((post) => (post.getTagsSelected()));
    var tags = _newPost.getTags();

    print("TAGS BUILT");
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            // return Container();
            return Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: ElevatedButton(
                onPressed: () => _newPost.onTagSelect(index),
                child: Text(tags[index]),
                style: ButtonStyle(
                  shape:
                      MaterialStateProperty.all<StadiumBorder>(StadiumBorder()),
                  backgroundColor: MaterialStateProperty.resolveWith(
                    (states) => tagsSelected[index]
                        ? Color((0xff11AA33).toInt()).withOpacity(0.8)
                        : Color((0x11111111).toInt()).withOpacity(0.3),
                  ),
                ),
              ),
            );
          }, childCount: tags.length),
        )
      ],
      scrollDirection: Axis.horizontal,
    );
  }
}

class PreviewPost extends StatefulWidget {
  @override
  _PreviewPost createState() => _PreviewPost();
}

class _PreviewPost extends State<PreviewPost> {
  var imageUrl;

  @override
  Widget build(BuildContext context) {
    NewPost _newPost = Provider.of<NewPost>(context, listen: false);
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    String uid = Provider.of<CurrentUser>(context).getUid;
    String username = Provider.of<CurrentUser>(context).getUsername;
    var tagsSelected =
        context.select<NewPost, List<bool>>((post) => (post.getTagsSelected()));

    uploadImage() async {
      // Upload to Firebase
      var firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child('posts/$uid${DateTime.now().millisecondsSinceEpoch}');
      var snapshot = await firebaseStorageRef.putFile(_newPost.getimagePath());

      var downloadUrl = await snapshot.ref.getDownloadURL();
      if (downloadUrl != null) {
        print("Image uploaded to cloud");
        _newPost.setImageUrl(downloadUrl);
      } else {
        print("Cannot upload to cloud");
      }
    }

    return Container(
      color: Colors.teal[50],
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.teal[50],
          body: Column(
            children: [
              Container(
                height: screenHeight * 0.05,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Post Preview",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: TextButton(
                          onPressed: () => uploadImage(),
                          child: Text(
                            "Post",
                            style: TextStyle(fontSize: 20, color: Colors.teal),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Post(
                username: username,
                imagePATH: _newPost.getimagePath(),
                likeCount: 999,
                caption: _newPost.getDescription(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
