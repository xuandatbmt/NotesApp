import 'package:flutter/material.dart';
import 'package:notes/themes/colors.dart';
import 'package:notes/widgets/custom_appbar.dart';

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
     body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 45, bottom: 45),
              child: CustomAppBar(
                title: 'Notification',
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
