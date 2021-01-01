import 'package:flutter/material.dart';
import 'package:notes/screens/add_note/components/text_field.dart';
import 'package:notes/widgets/custom_appbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddCategorycreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // var data = context.watch<Data>();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            CustomAppBar(
              title: 'Add Category',
              icon: FontAwesomeIcons.solidSave,
              onPressed: () {
                // if (data.title != '' && data.content != '') {
                //   data.addNote();
                //   Navigator.pop(context);
                // }
              },
            ),
            AddingTextField(maxLines: 1, hintText: 'Name Category'),
            // Flexible(child: AddingTextField(maxLines: 50, hintText: 'Note')),
          ],
        ),
      ),
    );
  }
}
