import 'package:flutter/material.dart';

class CheckLogin extends StatelessWidget {
  final bool islogin;
  final Function press;
  const CheckLogin({
    Key key,
    this.islogin = false,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: press,
        )
      ],
    );
  }
}
