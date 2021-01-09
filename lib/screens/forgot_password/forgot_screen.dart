import 'package:flutter/material.dart';
import 'package:notes/services/shared_pref.dart';
import 'package:provider/provider.dart';
import 'components/forgot_password_input.dart';

class ForgotPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = context.watch<SharedPref>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white10,
        brightness: theme.isNight ? Brightness.dark : Brightness.light,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ForgotPassInput(),
    );
  }
}
