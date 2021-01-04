import 'package:flutter/material.dart';
import 'package:notes/themes/colors.dart';

class Notify extends StatefulWidget {
  const Notify({
    Key key,
  }) : super(key: key);
  @override
  _NotifyPage createState() => _NotifyPage();
}

class _NotifyPage extends State<Notify> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications', style: TextStyle(color: textColor)),
        elevation: 0.0,
        backgroundColor: backgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Text('Chưa có thông báo nào!'),
      ),
    );
  }
}
