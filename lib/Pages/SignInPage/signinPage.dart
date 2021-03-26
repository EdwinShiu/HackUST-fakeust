import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Constants/constants.dart';
import '../../states/currentUser.dart';

class SigninPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    print('Sign in Page');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: const Color(backgroundPrimaryColor),
        width: screenWidth,
        child: Column(
          children: [
            //logo
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.15),
              child: Center(
                child: Container(
                  width: 200,
                  height: 150,
                  child: Image.asset('assets/images/logo.png'),
                ),
              ),
            ),
            SignInForm(),
            SizedBox(
              height: 50,
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(const Color(colorWhite)),
                  minimumSize: MaterialStateProperty.all<Size>(
                      Size(screenWidth * 0.15, 30)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                onPressed: () {
                  print("Return to startupPage");
                  Navigator.pop(context);
                },
                child: Text(
                  "Return",
                  style: TextStyle(
                    color: const Color(textPrimaryColor),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SignInForm extends StatefulWidget {
  @override
  _SignInForm createState() => _SignInForm();
}

class _SignInForm extends State<SignInForm> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwController = TextEditingController();

  void _signinUser(String email, String pw, BuildContext context) async {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);

    try {
      if (await _currentUser.signinUser(email, pw)) {
        print("Logged In!");
        Navigator.pop(context);
      } else {
        print("Incorrect email or password!");
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
        child: Column(
      children: [
        // email
        Padding(
          padding:
              EdgeInsets.only(top: screenHeight * 0.1, left: 15, right: 15),
          child: TextFormField(
            autocorrect: false,
            controller: _emailController,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
                hintText: 'Enter valid email id as abc@gmail.com'),
          ),
        ),
        // password
        Padding(
          padding: const EdgeInsets.only(
              left: 15.0, right: 15.0, top: 15, bottom: 0),
          //padding: EdgeInsets.symmetric(horizontal: 15),
          child: TextFormField(
            autocorrect: false,
            controller: _pwController,
            obscureText: true,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
                hintText: 'Enter password'),
          ),
        ),
        SizedBox(
          height: 50,
        ),
        Container(
          height: 50,
          width: 250,
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(20)),
          child: TextButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(const Color(colorWhite)),
              minimumSize:
                  MaterialStateProperty.all<Size>(Size(screenWidth * 0.65, 50)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            onPressed: () {
              print('Submit log in');
              _signinUser(_emailController.text, _pwController.text, context);
            },
            child: Text(
              'Login',
              style:
                  TextStyle(color: const Color(textPrimaryColor), fontSize: 25),
            ),
          ),
        ),
      ],
    ));
  }
}
