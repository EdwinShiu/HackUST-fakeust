import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      elevation: 16,
      child: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height * 0.2,
        padding: EdgeInsets.all(20.0),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              "Grant Permissions And Try Again",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () =>
                  openAppSettings().then((_) => Navigator.pop(context)),
              child: Text("Go To Setting"))
        ]),
      ),
    );
  }
}
