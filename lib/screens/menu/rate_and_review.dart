import 'package:flutter/material.dart';

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
      appBar: AppBar(
        title: Text('Đánh giá'),
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
        child: Text(''),
      ),
    );
  }
}
