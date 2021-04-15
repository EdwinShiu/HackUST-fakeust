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
      backgroundColor: Color(constants.backgroundPrimaryColor),
      // backgroundColor: Color.fromRGBO(239, 242, 200, 1),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            color: Color(constants.backgroundPrimaryColor),
            // color: Color.fromRGBO(239, 242, 200, 1),
            width: screenWidth,
            child: Column(
              children: [
                //logo
                /*  Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.15),
                  child: Center(
                    child: Container(
                      width: 200,
                      height: 150,
                      child: Image.asset('assets/images/logo.png'),
                    ),
                  ),
                ), */
                SignUpForm(),

                /* SizedBox(
                  height: 50,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(colorWhite)),
                      minimumSize: MaterialStateProperty.all<Size>(
                          Size(screenWidth * 0.15, 30)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    onPressed: () {
                      print("Return to Sign In Page");
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Return to Sign In Page",
                      style: TextStyle(
                        color: const Color(textPrimaryColor),
                      ),
                    ),
                  ),
                ), */
              ],
            ),
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
  TextEditingController _usernameController = TextEditingController();

  var _formKey = GlobalKey<FormState>();
  //String error = '';

  // ignore: non_constant_identifier_names
  UsernamePopUp(BuildContext context, TextEditingController email,
      TextEditingController username, TextEditingController password) {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape: (RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2),
              //  side: BorderSide(color: Colors.black, width: 2)
            )),
            contentPadding: EdgeInsets.fromLTRB(50.0, 50.0, 50.0, 50.0),
            backgroundColor: Color(constants.textFormColor),
            // backgroundColor: Color.fromRGBO(239, 242, 200, 1),
            title: Text("Enter your username:"),
            content: TextField(
              autocorrect: false,
              controller: username,
              decoration: InputDecoration(
                  contentPadding: new EdgeInsets.symmetric(
                      vertical: constants.textformVertPad, horizontal: 40.0),
                  border: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(60.0),
                  ),
                  fillColor: Color.fromRGBO(239, 242, 200, 1),
                  filled: true,
                  labelText: 'Username',
                  labelStyle: TextStyle(
                    color: Color.fromRGBO(8, 47, 69, 1),
                    fontSize: 15,
                  ),
                  hintText: 'Enter your username'),
            ),
            actions: <Widget>[
              MaterialButton(
                  minWidth: 100,
                  height: 50,
                  color: Color.fromRGBO(236, 238, 217, 1),
                  elevation: 0,
                  child: Text('RETURN'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              MaterialButton(
                minWidth: 100,
                height: 50,
                color: Color.fromRGBO(161, 246, 170, 1),
                elevation: 0,
                child: Text('SUBMIT'),
                onPressed: () async {
                  bool isRegistered = await _currentUser.RegisterWithEmailAndPW(
                      email.text, password.text, username.text);
                  if (isRegistered) {
                    print("Created account and Logged In!");
                    Navigator.popAndPushNamed(context, '/landing');
                  }
                },
              ),
            ],
          );
        });
  }

  void _signupUser(
      TextEditingController _email,
      TextEditingController _cemail,
      TextEditingController _pw,
      TextEditingController _cpw,
      TextEditingController _username,
      BuildContext context) async {
    try {
      if (_formKey.currentState.validate()) {
        Navigator.pop(UsernamePopUp(context, _email, _username, _pw));
        //if (result == null) {
        print('Cannot Sign up, please try again');
        // }
      } else {
        print("Incorrect email or password");
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            // email
            Padding(
              padding: EdgeInsets.only(
                  top: screenHeight * 0.25, left: 30, right: 30),
              child: TextFormField(
                autocorrect: false,
                controller: _emailController,
                validator: (String value) => (value.isNotEmpty &&
                        EmailValidator.validate(_emailController.text))
                    ? null
                    : 'Enter a valid email',
                decoration: InputDecoration(
                    contentPadding: new EdgeInsets.symmetric(
                        vertical: constants.textformVertPad, horizontal: 30.0),
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
                    hintText: 'Enter valid email id as abc@gmail.com'),
              ),
            ),
            // Confirm Email
            Padding(
              padding: const EdgeInsets.only(
                  left: 30.0, right: 30.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                autocorrect: false,
                controller: _email2Controller,
                validator: (String value) =>
                    (value.compareTo(_emailController.text) == 0)
                        ? null
                        : 'Enter the same email',
                decoration: InputDecoration(
                    contentPadding: new EdgeInsets.symmetric(
                        vertical: constants.textformVertPad, horizontal: 30.0),
                    fillColor: Color(constants.textFormColor),
                    filled: true, // <- this is required.
                    border: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(60.0),
                      // borderSide: new BorderSide(),
                    ),
                    labelText: 'Confirm Email',
                    labelStyle: TextStyle(
                      color: Color.fromRGBO(8, 47, 69, 1),
                      fontSize: 20,
                    ),
                    hintText: 'Enter the same email again to confirm'),
              ),
            ),
            // password
            Padding(
              padding: const EdgeInsets.only(
                  left: 30.0, right: 30.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                autocorrect: false,
                controller: _pwController,
                validator: (String value) =>
                    value.isEmpty ? 'Enter a password' : null,
                obscureText: true,
                decoration: InputDecoration(
                    contentPadding: new EdgeInsets.symmetric(
                        vertical: constants.textformVertPad, horizontal: 30.0),
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
            // Confirm password
            Padding(
              padding: const EdgeInsets.only(
                  left: 30.0, right: 30.0, top: 15, bottom: 0),
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
                    contentPadding: new EdgeInsets.symmetric(
                        vertical: constants.textformVertPad, horizontal: 30.0),
                    fillColor: Color(constants.textFormColor),
                    filled: true, // <- this is required.
                    border: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(60.0),
                      // borderSide: new BorderSide(),
                    ),
                    labelText: 'Confirm Password',
                    labelStyle: TextStyle(
                      color: Color.fromRGBO(8, 47, 69, 1),
                      fontSize: 20,
                    ),
                    hintText: 'Enter password again'),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: 50,
              width: 250,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
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
                  _signupUser(
                      _emailController,
                      _email2Controller,
                      _pwController,
                      _pw2Controller,
                      _usernameController,
                      context);
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
            SizedBox(height: screenHeight * 0.05),

            Container(
              height: 50,
              width: 250,

              // decoration: BoxDecoration(
              //     color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                // style: ButtonStyle(
                //   backgroundColor: MaterialStateProperty.all<Color>(
                //       Color.fromRGBO(236, 238, 217, 1)),
                //   minimumSize: MaterialStateProperty.all<Size>(
                //       Size(screenWidth * 0.65, 50)),
                //   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                //     RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(2),
                //       //  side: BorderSide(color: Colors.black, width: 2)
                //     ),
                //   ),
                //   // shape: MaterialStateProperty.all<StadiumBorder>(StadiumBorder()),
                // ),
                onPressed: () {
                  print('Go to sign up page');
                  Navigator.pop(context);
                },
                child: Text(
                  'Already have an account?',
                  style: TextStyle(color: Colors.blue, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
