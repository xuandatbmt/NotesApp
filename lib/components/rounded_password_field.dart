import 'package:flutter/material.dart';
import 'package:notes/components/text_field_container.dart';
import 'package:notes/config/constants.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final Function press;
  final String hintText;
  final bool isHiddenPassword;
  const RoundedPasswordField(
      {Key key,
      this.onChanged,
      this.press,
      this.hintText = "Password",
      this.isHiddenPassword = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: isHiddenPassword,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: hintText,
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: InkWell(
            onTap: press,
            child: Icon(
              isHiddenPassword ? Icons.visibility_off : Icons.visibility,
              color: kPrimaryColor,
            ),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
