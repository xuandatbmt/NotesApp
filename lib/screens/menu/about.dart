import 'package:flutter/material.dart';

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
        title: Text('Thông tin nhóm'),
        elevation: 0.0,
        backgroundColor: Colors.blue[200],
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
