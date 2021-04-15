import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Constants/constants.dart' as constants;
import '../../states/currentUser.dart';

class SigninPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    // var screenWidth = MediaQuery.of(context).size.width;
    print('Sign in Page');
    return Scaffold(
      // backgroundColor: Color.fromRGBO(239, 242, 200, 1),
      // backgroundColor: Color(constants.backgroundPrimaryColor),
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Container(
            height: screenHeight,
            decoration: BoxDecoration(
              // color: const Color(0xff000000),
              image: DecorationImage(
                image: AssetImage("assets/images/backgroundMap1.png"),
                fit: BoxFit.cover,
                colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(0.25), BlendMode.colorBurn),
              ),
            ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignInForm extends StatefulWidget {
  @override
  // _SignInForm createState() => _SignInForm();
  State<StatefulWidget> createState() {
    return _SignInForm();
  }
}

class _SignInForm extends State<SignInForm> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwController = TextEditingController();

  void _signinUser(String email, String pw, BuildContext context) async {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);

    try {
      if (await _currentUser.signinUser(email, pw)) {
        print("Logged In!");
        Navigator.popAndPushNamed(context, '/landing');
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
              EdgeInsets.only(top: screenHeight * 0.1, left: 30, right: 30),
          child: TextFormField(
            autocorrect: false,
            controller: _emailController,
            // style: new TextStyle(fontSize: 30),
            decoration: InputDecoration(
              contentPadding:
                  new EdgeInsets.symmetric(vertical: 25.0, horizontal: 30.0),
              // fillColor: Color.fromRGBO(211, 241, 206, 1),
              fillColor: Color(constants.textFormColor),
              filled: true, // <- this is required.
              border: OutlineInputBorder(
                borderRadius: new BorderRadius.circular(60.0),
                // borderSide: new BorderSide(),
              ),
              labelText: 'Email',
              labelStyle: TextStyle(
                color: Color.fromRGBO(8, 47, 69, 1),
                fontSize: 20,
              ),
              hintText: 'E.g. abc@gmail.com',
            ),
          ),
        ),
        // password
        Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 15),
          //padding: EdgeInsets.symmetric(horizontal: 15),
          child: TextFormField(
            autocorrect: false,
            controller: _pwController,
            obscureText: true,
            decoration: InputDecoration(
                contentPadding:
                    new EdgeInsets.symmetric(vertical: 25.0, horizontal: 30.0),
                // fillColor: Color.fromRGBO(211, 241, 206, 1),
                fillColor: Color(constants.textFormColor),
                filled: true, // <- this is required.
                border: OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(60.0),
                  // borderSide: new BorderSide(),
                ),
                labelText: 'Password',
                labelStyle: TextStyle(
                  color: Color.fromRGBO(8, 47, 69, 1),
                  fontSize: 20,
                ),
                hintText: 'Enter password'),
          ),
        ),
        SizedBox(
          height: 50,
        ),
        Container(
          height: 50,
          width: 250,
          // decoration: BoxDecoration(
          //     color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                // Color.fromRGBO(161, 246, 170, 1)),
                Colors.teal[50],
              ),
              minimumSize:
                  MaterialStateProperty.all<Size>(Size(screenWidth * 0.65, 50)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  // side: BorderSide(color: Colors.black, width: 2)
                ),
              ),
              // shape: MaterialStateProperty.all<StadiumBorder>(StadiumBorder()),
            ),
            onPressed: () {
              print('Submit log in');
              _signinUser(_emailController.text, _pwController.text, context);
            },
            child: Text(
              'LOG IN',
              style: TextStyle(
                  color: const Color(constants.textPrimaryColor), fontSize: 25),
            ),
          ),
        ),
        SizedBox(height: 30.0),

        FittedBox(
          // decoration: BoxDecoration(
          //     color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              // minimumSize:
              //     MaterialStateProperty.all<Size>(Size(screenWidth * 0.65, 50)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  // side: BorderSide(color: Colors.black, width: 2)
                  // color : Color.fromRGBO(236, 238, 217, 1)
                ),
              ),
              // shape: MaterialStateProperty.all<StadiumBorder>(StadiumBorder()),
            ),
            onPressed: () {
              print('Go to sign up page');
              Navigator.pushNamed(context, '/signup');
              // Navigator.of(context).popAndPushNamed('/signup');
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'SIGN UP FOR FREE',
                style: TextStyle(color: Colors.blue, fontSize: 13),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
