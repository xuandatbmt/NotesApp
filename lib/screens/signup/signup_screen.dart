import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:notes/components/already_have_an_account_acheck.dart';
import 'package:notes/components/background_login.dart';
import 'package:notes/components/rounded_button.dart';
import 'package:notes/components/rounded_input_field.dart';
import 'package:notes/components/rounded_password_field.dart';
import 'package:notes/config/constants.dart';
import 'package:notes/models/user_model.dart';
import 'package:notes/screens/login/login.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    Key key,
  }) : super(key: key);
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String _email;
  String _password;
  bool _isHidden = true;
  bool loading = false;

  Future<UserModel> createUser() async {
    var response = await http
        .post(
      'https://api-mobile-app.herokuapp.com/api/signup',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': _email,
        'password': _password,
      }),
    )
        .catchError((e) {
      throw (e);
    });

    // print(response.body);

    if (response.statusCode == 200) {
      showToast("User registered succesfully");
      // setState(() {
      //   loading = false;
      // });
      return userModelFromJson(response.body);
    } else {
      showToast(jsonDecode(response.body)['error'] ?? "Something went wrong");
      return null;
    }
  }

  showToast(String msg) {
    Fluttertoast.showToast(
      msg: "$msg",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
    );
  }

  _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGN UP",
              style: TextStyle(fontSize: 25, color: kPrimaryColor, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.05),
            // SvgPicture.asset(
            //   "assets/icons/signup1.svg",
            //   height: size.height * 0.35,
            // ),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {
                _email = value;
              },
            ),
            RoundedPasswordField(
              hintText: "Enter Password",
              isHiddenPassword: _isHidden,
              press: () {
                _togglePasswordView();
              },
              onChanged: (value) {
                _password = value;
              },
            ),
            RoundedPasswordField(
              hintText: "Retype Password",
              isHiddenPassword: _isHidden,
              press: () {
                _togglePasswordView();
              },
              onChanged: (value) {
                _password = value;
              },
            ),
            RoundedButton(
              text: "SIGN UP",
              press: createUser,
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) => Login()),
                    (Route<dynamic> route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
