import 'package:flutter/material.dart';
import 'package:hackust_fakeust/states/currentUser.dart';
import 'package:provider/provider.dart';

import '../../Constants/constants.dart';

class StartupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var uid = Provider.of<CurrentUser>(context).getUid;

    return SafeArea(
      child: Scaffold(
        body: Container(
          color: const Color(backgroundPrimaryColor),
          width: screenWidth,
          child: Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.6),
            child: Column(
              children: [
                Text("Signed in user ID: $uid"),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(colorWhite)),
                    minimumSize: MaterialStateProperty.all<Size>(
                        Size(screenWidth * 0.65, 50)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/signin');
                  },
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                      color: const Color(textPrimaryColor),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(colorWhite)),
                    minimumSize: MaterialStateProperty.all<Size>(
                        Size(screenWidth * 0.65, 50)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      color: const Color(textPrimaryColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
