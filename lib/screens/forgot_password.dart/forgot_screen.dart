import 'package:flutter/material.dart';

import 'components/forgot_password_input.dart';

class ForgotPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
        elevation: 0.0,
        backgroundColor: Colors.blue[500],
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
