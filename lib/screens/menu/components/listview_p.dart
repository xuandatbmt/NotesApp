import 'package:flutter/material.dart';
import 'package:notes/models/priority_model.dart';
import 'dismissible_p.dart';

class CustomListView extends StatelessWidget {
  final List<Priority> priority;
  final int index;
  const CustomListView({Key key, this.priority, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(10),
      physics: BouncingScrollPhysics(),
      itemCount: this.priority.length,
      itemBuilder: (context, index) =>
          CustomDismissible(priority: priority, index: index),
    );
  }
}
