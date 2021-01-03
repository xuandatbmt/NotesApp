import 'package:flutter/material.dart';
import 'package:notes/models/status_model.dart';
import 'dismissible_s.dart';

class CustomListView extends StatelessWidget {
  final List<Status> status;
  final int index;
  const CustomListView({Key key, this.status, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(10),
      physics: BouncingScrollPhysics(),
      itemCount: this.status.length,
      itemBuilder: (context, index) =>
          CustomDismissible(status: status, index: index),
    );
  }
}
