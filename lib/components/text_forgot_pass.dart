import 'package:flutter/material.dart';
import 'package:notes/config/constants.dart';

class ForgotPass extends StatelessWidget {
  final bool formlogin;
  final Function press;
  const ForgotPass({
    Key key,
    this.formlogin = true,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // Text(
        //   login ? "Don’t have an Account ? " : "Already have an Account ? ",
        //   style: TextStyle(color: kPrimaryColor),
        // ),
        GestureDetector(
          onTap: press,
          child: Text(
            formlogin ? "Forgot Password ? " : "Back",
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
