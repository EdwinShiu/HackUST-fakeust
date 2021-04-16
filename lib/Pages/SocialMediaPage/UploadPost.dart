import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hackust_fakeust/Cards/travellogCard.dart';
import 'package:hackust_fakeust/Components/permissionDialog.dart';
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

  selectImage(int mode) async {
    final _picker = ImagePicker();
    PickedFile image;

    //Check Permissions

    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select Image
      try {
        image = mode == 0
            ? await _picker.getImage(source: ImageSource.gallery)
            : await _picker.getImage(source: ImageSource.camera);
      } catch (err) {
        showDialog(
          context: context,
          builder: (context) {
            return PermissionDialog();
          },
        );
      }

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
    MapDataProvider mapData = Provider.of<MapDataProvider>(context);
    // print(Provider.of<MapDataProvider>(context).findLocation());
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    CurrentUser user = Provider.of<CurrentUser>(context);

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
                color: Colors.teal[50],
                child: Column(
                  children: [
                    // top info bar
                    Container(
                      height: screenHeight * 0.05,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(),
                          ),
                          Expanded(
                            flex: 4,
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                "Select Photo",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: (imagePath == null)
                                ? Container()
                                : Padding(
                                    padding: const EdgeInsets.only(right: 5.0),
                                    child: TextButton(
                                      onPressed: () {
                                        // _description
                                        _newPost
                                            .setDescription(_description.text);
                                        _newPost.setImagePath(this.imagePath);
                                        user.updateLocationInfo(
                                            mapData.findLocation(),
                                            mapData.findRegion());

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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Upload Image from Gallery",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, bottom: 20.0),
                                  child: FloatingActionButton(
                                    heroTag: "selectAnotherImage",
                                    onPressed: () => selectImage(0),
                                    child: Icon(Icons.photo),
                                  ),
                                ),
                                Text(
                                  "Take a Photo",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: FloatingActionButton(
                                    heroTag: "takeAnotherImage",
                                    onPressed: () => selectImage(1),
                                    child: Icon(Icons.camera_alt_rounded),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(
                            child: Column(
                              children: [
                                Container(
                                  height: screenHeight * imageArea,
                                  // image background
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: FileImage(imagePath),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  height: screenHeight * 0.07,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          "Description",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black),
                                        ),
                                      ),
                                      SizedBox(
                                        height: screenHeight * 0.05,
                                        child: Row(
                                          children: [
                                            FloatingActionButton(
                                              heroTag: "selectAnotherImage",
                                              onPressed: () => selectImage(0),
                                              child: Icon(Icons.photo,
                                                  size: screenHeight *
                                                      0.07 *
                                                      0.5),
                                            ),
                                            FloatingActionButton(
                                              heroTag: "takeAnotherImage",
                                              onPressed: () => selectImage(1),
                                              child: Icon(
                                                  Icons.camera_alt_rounded,
                                                  size: screenHeight *
                                                      0.07 *
                                                      0.5),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
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
                                Container(
                                  height: screenHeight * 0.05,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Text(
                                        "Add some Tags!",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 40,
                                  child: TagsScrollView(),
                                )
                              ],
                            ),
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
    return Container(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              // return Container();
              return Container(
                padding: const EdgeInsets.only(left: 10.0),
                margin: EdgeInsets.symmetric(vertical: 4.0),
                height: 20,
                child: ElevatedButton(
                  onPressed: () => _newPost.onTagSelect(index),
                  child: Text(tags[index]),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<StadiumBorder>(
                        StadiumBorder()),
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => tagsSelected.contains(tags[index])
                          ? Color(tagColor[tags[index]])
                          : Color((0x11111111).toInt()).withOpacity(0.3),
                    ),
                  ),
                ),
              );
            }, childCount: tags.length),
          )
        ],
        scrollDirection: Axis.horizontal,
      ),
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
    MapDataProvider mapData = Provider.of<MapDataProvider>(context);

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
        print(user.getLocationName);
        print(user.getLocationId);
        print(user.getRegionName);
        print(user.getRegionId);

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
