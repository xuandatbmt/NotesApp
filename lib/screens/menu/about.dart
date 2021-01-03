import 'package:flutter/material.dart';
import 'package:notes/themes/colors.dart';

class About extends StatefulWidget {
  const About({
    Key key,
  }) : super(key: key);
  @override
  _AboutPage createState() => _AboutPage();
}

class _AboutPage extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us', style: TextStyle(color: textColor)),
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
        child: Text('Text!'),
      ),
    );
  }
}
