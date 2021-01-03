import 'package:flutter/material.dart';
import 'package:notes/models/category_model.dart';
import 'package:notes/models/notes_model.dart';
import 'dismissible_c.dart';

class CustomListView extends StatelessWidget {
  final List<Category> category;
  final int index;
  const CustomListView({Key key, this.category, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(10),
      physics: BouncingScrollPhysics(),
      itemCount: this.category.length,
      itemBuilder: (context, index) =>
          CustomDismissible(category: category, index: index),
    );
  }
}
