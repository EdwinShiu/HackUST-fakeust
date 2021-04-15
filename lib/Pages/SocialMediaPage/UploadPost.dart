import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hackust_fakeust/Cards/travellogCard.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../../states/currentUser.dart';
import '../../models/new_post.dart';
import '../../models/post_model.dart';
import "../../Constants/constants.dart";
import '../../Components/post.dart';
import '../../models/mapDataProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UploadPost extends StatefulWidget {
  @override
  _UploadPost createState() => _UploadPost();
}

class _UploadPost extends State<UploadPost> {
  var imagePath;
  var location;

  TextEditingController _description = TextEditingController();

  @override
  void initState() {
    super.initState();
    // setState(() {
    //   location = _determinePosition();
    // });
  }

  // // get location
  // Future<Position> _determinePosition() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   // Test if location services are enabled.
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     // Location services are not enabled don't continue
  //     // accessing the position and request users of the
  //     // App to enable the location services.
  //     return Future.error('Location services are disabled.');
  //   }

  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.deniedForever) {
  //       return Future.error(
  //           'Location permissions are permanently denied, we cannot request permissions.');
  //     }

  //     if (permission == LocationPermission.denied) {
  //       return Future.error('Location permissions are denied');
  //     }
  //   }

  //   // When we reach here, permissions are granted and we can
  //   // continue accessing the position of the device.
  //   var loc = await Geolocator.getCurrentPosition();
  //   print(loc.toString());
  //   return loc;
  // }

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
    print(Provider.of<MapDataProvider>(context).findLocation());
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    String uid = Provider.of<CurrentUser>(context).getUid;
    NewPost _newPost = Provider.of<NewPost>(context, listen: false);
    List<String> tagsSelected = _newPost.getTagsSelected();

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
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
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
                            height: screenHeight * imageArea,
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
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: FloatingActionButton(
                                        heroTag: "addPost",
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
                            height: screenHeight * imageArea,
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
                        : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Container(
                              height: screenHeight * 0.07,
                              color: Colors.teal[50],
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: SizedBox(
                                        height: screenHeight * 0.05,
                                        child: FloatingActionButton(
                                          heroTag: "selectAnotherImage",
                                          onPressed: () => selectImage(),
                                          child: Icon(Icons.photo,
                                              size: screenHeight * 0.07 * 0.5),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Align(
                                  //   alignment: Alignment.centerRight,
                                  //   child: Padding(
                                  //     padding: const EdgeInsets.only(
                                  //         top: 0.0, bottom: 0, right: 55),
                                  //     child: Container(
                                  //       height: 50,
                                  //       width: 55,
                                  //       child: Align(
                                  //         alignment: Alignment.center,
                                  //         child: Text(
                                  //           "Another Photo",
                                  //           textAlign: TextAlign.center,
                                  //           style: TextStyle(
                                  //               fontSize: 14,
                                  //               color: Colors.black),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        "Description",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                    (imagePath == null)
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.only(
                                bottom: 20, left: 10, right: 10),
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
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  "Add some Tags!",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                              ),
                            )),
                    (imagePath == null)
                        ? Container()
                        : Container(
                            height: 40,
                            child: TagsScrollView(),
                          ),
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

    var tags =
        context.select<NewPost, List<String>>((post) => (post.getTags()));
    var tagsSelected = context
        .select<NewPost, List<String>>((post) => (post.getTagsSelected()));
    // var tags = _newPost.getTags();

    // print("TAGS BUILT");
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            // return Container();
            return Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 5),
              child: ElevatedButton(
                onPressed: () => _newPost.onTagSelect(index),
                child: Text(tags[index]),
                style: ButtonStyle(
                  shape:
                      MaterialStateProperty.all<StadiumBorder>(StadiumBorder()),
                  backgroundColor: MaterialStateProperty.resolveWith(
                    (states) => tagsSelected.contains(tags[index])
                        ? Color((Random().nextDouble() * 0xFFFFFFFF).toInt())
                            .withOpacity(1)
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
  bool sendingPost = false;
  bool sentPost = false;

  @override
  Widget build(BuildContext context) {
    NewPost _newPost = Provider.of<NewPost>(context, listen: false);
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    CurrentUser user = Provider.of<CurrentUser>(context);

    sendPost() async {
      setState(() {
        sendingPost = true;
      });

      // Upload to Firebase
      var firebaseStorageRef = FirebaseStorage.instance.ref().child(
          'posts/${user.getUid}${DateTime.now().millisecondsSinceEpoch}');
      var snapshot = await firebaseStorageRef.putFile(_newPost.getimagePath());

      var downloadUrl = await snapshot.ref.getDownloadURL();
      if (downloadUrl != null) {
        print("Image uploaded to cloud");
        _newPost.setImageUrl(downloadUrl);

        // upload to Firestore
        List<String> tagsSelected = _newPost.getTagsSelected();

        int numPosts;
        await FirebaseFirestore.instance
            .collection("posts")
            .get()
            .then((query) => numPosts = query.docs.length);

        String timestamp = DateTime.now().toString();

        FirebaseFirestore.instance.collection("posts").doc("$numPosts").set({
          "create_date": timestamp,
          "description": _newPost.getDescription(),
          "region_id": user.getRegionId,
          "location_id": user.getLocationId,
          "country_id": 0,
          "region_name": user.getRegionName,
          "location_name": user.getLocationName,
          "image_URL": _newPost.getimageUrl(),
          "liked_uid": 0,
          "tags": tagsSelected,
          "uid": user.getUid,
          "username": user.getUsername,
          "post_id": numPosts.toString(),
        }).then((_) {
          print("Post sent!");
          setState(() {
            sentPost = true;
          });
        });

        FirebaseFirestore.instance
            .collection("users")
            .doc("${user.getUid}")
            .get()
            .then((document) {
          int newNum;
          if (document.data()['travelled_regions'][user.getRegionId] == null)
            newNum = 1;
          else
            newNum = document.data()['travelled_regions'][user.getRegionId] + 1;
          FirebaseFirestore.instance
              .collection("users")
              .doc("${user.getUid}")
              .update({
            'travelled_regions.${user.getRegionId}': newNum,
          }).then((_) {
            Future.delayed(Duration(milliseconds: 1000), () {
              // Do something
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/landing', (Route<dynamic> route) => false);
            });
          });
        });
      } else {
        print("Cannot upload to cloud");
      }
    }

    return sendingPost
        ? Container(
            color: Colors.teal[50],
            child: SafeArea(
              child: Scaffold(
                backgroundColor: Colors.teal[50],
                body: sentPost
                    ? Center(
                        child: Icon(Icons.done),
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
            ),
          )
        : Container(
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
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: TextButton(
                                onPressed: () => sendPost(),
                                child: Text(
                                  "Post",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.teal),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Post(
                      post: PostModel(
                        description: _newPost.getDescription(),
                        image_URL: "",
                        username: user.getUsername,
                        location_name: user.getLocationName,
                        region_name: user.getRegionName,
                        tags: _newPost.getTagsSelected(),
                      ),
                      imagePATH: _newPost.getimagePath(),
                    ),
                    SizedBox(
                      height: screenHeight * 0.05,
                    ),
                    TravelLogCard(
                      locationName: user.getLocationName,
                      regionName: user.getRegionName,
                      description: _newPost.getDescription(),
                      imagePath: _newPost.getimagePath(),
                      imageUrl: _newPost.getimageUrl(),
                      date: DateTime.now().toString(),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
