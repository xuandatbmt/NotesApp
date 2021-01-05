import 'package:flutter/material.dart';
import 'package:notes/themes/colors.dart';
import 'package:notes/widgets/custom_appbar.dart';

class RateandReview extends StatefulWidget {
  const RateandReview({
    Key key,
  }) : super(key: key);
  @override
  _RateandReviewPage createState() => _RateandReviewPage();
}

class _RateandReviewPage extends State<RateandReview> {
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
                title: 'Rating',
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
