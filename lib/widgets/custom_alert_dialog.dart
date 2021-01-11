import 'package:flutter/material.dart';
import 'package:notes/localization/localization_constants.dart';

class CustomAlertDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget myFlatButton(title, color, value) {
      return FlatButton(
        child: Text(
          title,
          style: TextStyle(color: color),
        ),
        onPressed: () => Navigator.of(context).pop(value),
      );
    }

    return AlertDialog(
      title: Text(getTranslated(context, 'confirm_delete')),
      content: Text(getTranslated(context, 'delete_question')),
      actions: <Widget>[
        myFlatButton(getTranslated(context, 'btn_delete'), Colors.redAccent, true),
        myFlatButton(getTranslated(context, 'btn_cancel'), Colors.grey, false),
      ],
      contentPadding: EdgeInsets.fromLTRB(25, 15, 25, 5),
      insetPadding: EdgeInsets.symmetric(horizontal: 20),
    );
  }
}
