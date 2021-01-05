import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes/screens/settings/components/list_tile.dart';
import 'package:notes/themes/colors.dart';
import 'package:notes/widgets/custom_appbar.dart';

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
     body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 45, bottom: 45),
              child: CustomAppBar(
                title: 'About Us',
                isVisible: false,
              ),
            ),
            Center(
              child: Text("Text"),
            )
          ],
        ),
      ),
    );
  }
}
