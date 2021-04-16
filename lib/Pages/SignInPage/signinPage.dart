import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Constants/constants.dart' as constants;
import '../../states/currentUser.dart';

class SigninPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    // var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
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
                image: AssetImage("assets/images/backgroundMap3.jpg"),
                fit: BoxFit.cover,
                colorFilter: new ColorFilter.mode(
                  Colors.black.withOpacity(0.1),
                  BlendMode.colorBurn,
                ),
              ),
            ),
            child: Column(
              children: [
                //logo
                Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.15),
                  child: Image(
                    height: screenHeight * 0.2,
                    image: AssetImage('assets/images/logo.png'),
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
        Navigator.popAndPushNamed(context, '/landing');
      } else {}
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
              enabledBorder: OutlineInputBorder(
                borderRadius: new BorderRadius.circular(60.0),
                borderSide: BorderSide(width: constants.textformBorderWidth),
              ),
              border: OutlineInputBorder(
                borderRadius: new BorderRadius.circular(60.0),
                // borderSide: new BorderSide(),
              ),
              labelText: 'Email',
              labelStyle: TextStyle(
                // color: Color.fromRGBO(8, 47, 69, 1),
                color: Color(constants.textformFontColor),
                fontSize: constants.textformlabelFontSize,
                fontWeight: FontWeight.bold,
              ),
              hintText: 'E.g. abc@gmail.com',
              hintStyle: TextStyle(
                color: Color(constants.textformFontColor),
              ),
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
              enabledBorder: OutlineInputBorder(
                borderRadius: new BorderRadius.circular(60.0),
                borderSide: BorderSide(width: constants.textformBorderWidth),
              ),
              border: OutlineInputBorder(
                borderRadius: new BorderRadius.circular(60.0),
                // borderSide: new BorderSide(),
              ),
              labelText: 'Password',
              labelStyle: TextStyle(
                color: Color(constants.textformFontColor),
                fontSize: constants.textformlabelFontSize,
                fontWeight: FontWeight.bold,
              ),
              hintText: 'Enter password',
              hintStyle: TextStyle(
                color: Color(constants.textformFontColor),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 50,
        ),
        Container(
          height: 50,
          width: 250,
          child: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                Colors.teal[50],
              ),
              minimumSize:
                  MaterialStateProperty.all<Size>(Size(screenWidth * 0.65, 50)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            onPressed: () {
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
          child: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/signup');
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
