import 'package:flutter/material.dart';
import 'package:notes/models/notes_model.dart';
import 'dismissible.dart';

class CustomListView extends StatelessWidget {
  final List<Notes> notes;
  final int index;
  const CustomListView({Key key, this.notes, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(10),
      physics: BouncingScrollPhysics(),
      itemCount: this.notes.length,
      itemBuilder: (context, index) =>
          CustomDismissible(notes: notes, index: index),
    );
  }
}
