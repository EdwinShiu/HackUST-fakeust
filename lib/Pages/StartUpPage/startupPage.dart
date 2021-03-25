import 'package:flutter/material.dart';

import '../../Constants/constants.dart';

class StartupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    print('Height: ' + screenHeight.toString());

    return SafeArea(
      child: Scaffold(
        body: Container(
          color: const Color(backgroundPrimaryColor),
          width: screenWidth,
          child: Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.6),
            child: Column(
              children: [
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
                    print("Login");
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
                  onPressed: () {
                    print("Sign Up");
                  },
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
