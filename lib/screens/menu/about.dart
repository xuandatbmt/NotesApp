import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/localization/localization_constants.dart';
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
                title: getTranslated(context, 'about_us_screen'),
                isVisible: false,
              ),
            ),
            Center(
              child: Text(getTranslated(context, 'test_text')),
            )
          ],
        ),
      ),
    );
  }
}
