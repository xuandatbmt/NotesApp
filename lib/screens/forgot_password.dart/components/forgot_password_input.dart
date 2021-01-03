import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:notes/components/background_login.dart';
import 'package:notes/components/rounded_button.dart';
import 'package:notes/components/rounded_input_field.dart';
import 'package:notes/config/constants.dart';
import 'package:notes/models/user_model.dart';

class ForgotPassInput extends StatefulWidget {
  final String hintText;
  final IconData icon;
  const ForgotPassInput({
    Key key,
    this.hintText = "Điền Email",
    this.icon = Icons.email,
    //  this.onChanged,
  }) : super(key: key);
  @override
  _ForgotPassInputState createState() => _ForgotPassInputState();
}

class _ForgotPassInputState extends State<ForgotPassInput> {
  String _email;

  Future<UserModel> forgotPassWord() async {
    var response = await http
        .post(
      'https://api-mobile-app.herokuapp.com/api/resetpass',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': _email,
      }),
    )
        .catchError((e) {
      throw (e);
    });

    print(response.body);
    if (response.statusCode == 200) {
      showToast(jsonDecode(response.body)['message']);
      // setState(() {
      //   loading = false;
      // });
      return userModelFromJson(response.body);
    } else
      return showToast(
          jsonDecode(response.body)['error'] ?? "Something went wrong");
  }

  showToast(String msg) {
    Fluttertoast.showToast(
      msg: "$msg",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
    );
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
              "FORGOT PASSWORD",
               style: TextStyle(fontSize: 25, color: kPrimaryColor, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            // SvgPicture.asset(
            //   "assets/icons/login1.svg",
            //   height: size.height * 0.35,
            // ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {
                _email = value;
              },
            ),
            // SizedBox(height: size.height * 0.03),
            RoundedButton(
              text: "CONFIRM",
              press: forgotPassWord,
            ),
            SizedBox(height: size.height * 0.03),
          ],
        ),
      ),
    );
  }
}
