import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Constants/constants.dart' as constants;
import '../../states/currentUser.dart';
import 'package:email_validator/email_validator.dart';

class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    print('Sign Up Page');
    return Scaffold(
      // backgroundColor: Color(constants.backgroundPrimaryColor),
      // backgroundColor: Color.fromRGBO(239, 242, 200, 1),
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: screenHeight,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/backgroundMap2.png"),
                    fit: BoxFit.cover,
                    colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.35),
                      BlendMode.colorBurn,
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.06),
                  child: Image(
                    height: screenHeight * 0.2,
                    image: AssetImage('assets/images/logo.png'),
                  ),
                ),
              ),
              SignUpForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  @override
  // _SignInForm createState() => _SignInForm();
  State<StatefulWidget> createState() {
    return _SignUpForm();
  }
}

class _SignUpForm extends State<SignUpForm> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _email2Controller = TextEditingController();
  TextEditingController _pwController = TextEditingController();
  TextEditingController _pw2Controller = TextEditingController();
  // TextEditingController _usernameController = TextEditingController();

  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);

    return Form(
      key: _formKey,
      child: Column(
        children: [
          // email
          Padding(
            padding: EdgeInsets.only(
                top: screenHeight * 0.30,
                left: constants.textformHorPad,
                right: constants.textformHorPad),
            child: TextFormField(
              autocorrect: false,
              controller: _emailController,
              validator: (String value) => (value.isNotEmpty &&
                      EmailValidator.validate(_emailController.text))
                  ? null
                  : 'Enter a valid email',
              decoration: InputDecoration(
                errorStyle: constants.textformErrorStyle,
                contentPadding: new EdgeInsets.symmetric(
                    vertical: constants.textformVertPad, horizontal: 30.0),
                fillColor: Color(constants.textFormColor),
                filled: true, // <- this is required.
                enabledBorder: OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(60.0),
                  borderSide: BorderSide(width: constants.textformBorderWidth),
                ),
                border: OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(60.0),
                ),
                labelText: 'Email',
                labelStyle: TextStyle(
                  color: Color(constants.textformFontColor),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                hintText: 'E.g. abc@gmail.com',
                hintStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // Confirm Email
          Padding(
            padding: EdgeInsets.only(
                left: constants.textformHorPad,
                right: constants.textformHorPad,
                top: constants.textformSep,
                bottom: 0),
            //padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextFormField(
              autocorrect: false,
              controller: _email2Controller,
              validator: (String value) {
                if (_emailController.text == null)
                  return null;
                else
                  return (value.compareTo(_emailController.text) == 0)
                      ? null
                      : 'Enter the same email';
              },
              decoration: InputDecoration(
                errorStyle: constants.textformErrorStyle,
                contentPadding: new EdgeInsets.symmetric(
                    vertical: constants.textformVertPad, horizontal: 30.0),
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
                labelText: 'Confirm Email',
                labelStyle: TextStyle(
                  color: Color(constants.textformFontColor),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                hintText: 'Enter Email again',
                hintStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // password
          Padding(
            padding: EdgeInsets.only(
                left: constants.textformHorPad,
                right: constants.textformHorPad,
                top: constants.textformSep,
                bottom: 0),
            //padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextFormField(
              autocorrect: false,
              controller: _pwController,
              validator: (String value) =>
                  value.isEmpty ? 'Enter a password' : null,
              obscureText: true,
              decoration: InputDecoration(
                errorStyle: constants.textformErrorStyle,
                contentPadding: new EdgeInsets.symmetric(
                    vertical: constants.textformVertPad, horizontal: 30.0),
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
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                hintText: 'Enter password',
                hintStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // Confirm password
          Padding(
            padding: EdgeInsets.only(
                left: constants.textformHorPad,
                right: constants.textformHorPad,
                top: constants.textformSep,
                bottom: 0),
            //padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextFormField(
              autocorrect: false,
              controller: _pw2Controller,
              validator: (String value) =>
                  (value.compareTo(_pwController.text) == 0)
                      ? null
                      : 'Enter the same password to confirm',
              obscureText: true,
              decoration: InputDecoration(
                errorStyle: constants.textformErrorStyle,
                contentPadding: new EdgeInsets.symmetric(
                    vertical: constants.textformVertPad, horizontal: 30.0),
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
                labelText: 'Confirm Password',
                labelStyle: TextStyle(
                  color: Color(constants.textformFontColor),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                hintText: 'Enter password again',
                hintStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.06,
          ),
          Container(
            height: 50,
            width: 250,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.teal[50],
                ),
                minimumSize: MaterialStateProperty.all<Size>(
                    Size(screenWidth * 0.65, 50)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    //  side: BorderSide(color: Colors.black, width: 2)
                  ),
                ),
              ),
              onPressed: () {
                if (_formKey.currentState.validate())
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return CreateUsername(
                        email: _emailController.text,
                        password: _pwController.text,
                      );
                    },
                  );

                print('submit username');
              },
              child: Text(
                'SIGN UP',
                style: TextStyle(
                    color: const Color(constants.textPrimaryColor),
                    fontSize: 25),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.03),

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
                print('Go to sign in');
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Already have an account?',
                  style: TextStyle(color: Colors.blue, fontSize: 13),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: non_constant_identifier_names
class CreateUsername extends StatefulWidget {
  final String email;
  final String password;
  final TextEditingController _usernameController = TextEditingController();

  CreateUsername({Key key, @required this.email, @required this.password})
      : super(key: key);

  @override
  _CreateUsername createState() => _CreateUsername();
// (BuildContext context, TextEditingController email,
//     TextEditingController username, TextEditingController password)
}

class _CreateUsername extends State<CreateUsername> {
  @override
  Widget build(BuildContext context) {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Dialog(
      shape: (RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      )),
      child: Container(
        height: screenHeight * 0.2,
        decoration: BoxDecoration(
          color: const Color(0xff7c94b6),
          image: const DecorationImage(
            image: AssetImage("assets/images/username.png"),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(
                    left: screenWidth * 0.05, top: screenWidth * 0.05),
                child: Text(
                  "Enter your Username",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.05),
                child: Image(
                  height: screenHeight * 0.05,
                  image: AssetImage("assets/images/mapPin.png"),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.15, right: 10),
                child: TextField(
                  autocorrect: false,
                  controller: widget._usernameController,
                  decoration: InputDecoration(
                      contentPadding: new EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(60.0),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      labelText: 'Username',
                      labelStyle: TextStyle(
                        color: Color.fromRGBO(8, 47, 69, 1),
                        fontSize: 15,
                      ),
                      hintText: 'Enter your username'),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(
                  right: screenHeight * 0.02,
                ),
                child: TextButton(
                  child: Text(
                    "Submit",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () async {
                    //add loading animation here
                    bool isRegistered =
                        await _currentUser.RegisterWithEmailAndPW(widget.email,
                            widget.password, widget._usernameController.text);
                    if (isRegistered) {
                      print("Created account and Logged In!");
                      Navigator.popAndPushNamed(context, '/landing');
                      // add welcome message
                    }
                    // else {
                    //   showDialog(
                    //     context: context,
                    //     builder: (context) {
                    //       return Dialog(
                    //         child: Container(
                    //           height: screenHeight * 0.1,
                    //           child: Center(
                    //             child: Text("Please try againt"),
                    //           ),
                    //         ),
                    //       );
                    //     },
                    //   );
                    // }
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  left: screenHeight * 0.02,
                ),
                child: TextButton(
                  child: Text(
                    "Return",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () async => Navigator.pop(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
