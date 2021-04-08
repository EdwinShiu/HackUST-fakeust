import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../../states/currentUser.dart';

class UploadPost extends StatefulWidget {
  @override
  _UploadPost createState() => _UploadPost();
}

class _UploadPost extends State<UploadPost> {
  var imagePath;
  var imageUrl;

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

  uploadImage(String uid) async {
    // Upload to Firebase
    var firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('posts/$uid${DateTime.now().millisecondsSinceEpoch}');
    var snapshot = await firebaseStorageRef.putFile(imagePath);

    var downloadUrl = await snapshot.ref.getDownloadURL();
    if (downloadUrl != null) {
      print("Image uploaded to cloud");
      setState(() {
        imageUrl = downloadUrl;
      });
    } else {
      print("Cannot upload to cloud");
    }
  }

  @override
  Widget build(BuildContext context) {
    String uid = Provider.of<CurrentUser>(context).getUid;

    print("upload post page built");
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: Container(
            child: Column(
              children: [
                Column(
                  children: [
                    Text(
                      "Upload from gallery",
                      style: TextStyle(fontSize: 20),
                    ),
                    FloatingActionButton(
                      onPressed: () => selectImage(),
                      child: Icon(Icons.file_upload),
                    ),
                  ],
                ),
                (imagePath == null)
                    ? Container()
                    : Container(
                        height: 500,
                        // image background
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(imagePath),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                (imagePath == null)
                    ? Container()
                    : Column(
                        children: [
                          Text(
                            "Post!",
                            style: TextStyle(fontSize: 20),
                          ),
                          FloatingActionButton(
                            onPressed: () => uploadImage(uid),
                            child: Icon(Icons.send),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
