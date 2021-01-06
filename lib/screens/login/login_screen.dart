import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:notes/components/already_have_an_account_acheck.dart';
import 'package:notes/components/background_login.dart';
import 'package:notes/components/or_divider.dart';
import 'package:notes/components/rounded_button.dart';
import 'package:notes/components/rounded_input_field.dart';
import 'package:notes/components/rounded_password_field.dart';
import 'package:notes/components/social_icon.dart';
import 'package:notes/components/text_forgot_pass.dart';
import 'package:notes/config/constants.dart';
import 'package:notes/models/global.dart';
import 'package:notes/models/user_model.dart';
import 'package:notes/screens/forgot_password/forgot_screen.dart';
import 'package:notes/screens/home/home.dart';
import 'package:notes/screens/login/login_facebook.dart';
import 'package:notes/screens/login/login_google.dart';
import 'package:notes/screens/signup/signup.dart';
import 'package:notes/services/shared_pref.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key key,
  }) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool login = false;
  String _email;
  String _password;
  bool isHidden = true;
  String token;
  // bool _isLoading = false;
  _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
  }

  // _readToken() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final key = 'token';
  //   final value = prefs.get(key) ?? 0;
  //   print('read : $value');
  // }

  Future<UserModel> loginUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var response = await http
        .post(
      URL_API + '/signin',
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
    if (response.statusCode == 200) {
      showToast("Login succesful");
      var data = json.decode(response.body);
      if (data['refreshToken'] != null) {
        _saveToken(data['refreshToken']);
        token = sharedPreferences.getString("token");
        await sharedPreferences.setString("token", data['refreshToken']);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
            (Route<dynamic> route) => false);
      }
      return userModelFromJson(response.body);
    } else {
      setState(() {
        login = false;
      });
      showToast(jsonDecode(response.body)['error'] ?? "Something went wrong");
      return null;
    }
  }

  SharedPreferences sharedPreferences;
  showToast(String msg) {
    Fluttertoast.showToast(
      msg: "$msg",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
    );
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") != null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
          (Route<dynamic> route) => false);
    }
  }

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    context.read<SharedPref>().getTheme();
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
              "LOGIN",
              style: TextStyle(
                  fontSize: 25,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.05),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {
                _email = value;
              },
            ),
            RoundedPasswordField(
              isHiddenPassword: isHidden,
              press: () {
                setState(() {
                  isHidden = !isHidden;
                });
              },
              onChanged: (value) {
                _password = value;
              },
            ),
            RoundedButton(
              text: "LOGIN",
              press: loginUser,
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUp();
                    },
                  ),
                );
              },
            ),
            SizedBox(height: size.height * 0.03),
            ForgotPass(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ForgotPassword();
                    },
                  ),
                );
              },
            ),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocalIcon(
                  iconSrc: "assets/icons/facebook.svg",
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginWithFacebook();
                          //test
                        },
                      ),
                    );
                  },
                ),
                SocalIcon(
                  iconSrc: "assets/icons/google.svg",
                  press: () {
                    final provider = Provider.of<GoogleSignInProvider>(context,
                        listen: false);
                    provider.login();
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
