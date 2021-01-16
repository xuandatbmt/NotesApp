import 'package:flutter/material.dart';
import 'package:notes/localization/localization_constants.dart';
import 'package:notes/screens/add_note/components/text_field.dart';
import 'package:notes/services/data.dart';
import 'package:notes/widgets/custom_appbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AddStatus extends StatelessWidget {
  String _nameStatus;
  @override
  Widget build(BuildContext context) {
    var data = context.watch<Data>();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            CustomAppBar(
              title: getTranslated(context, 'add_status'),
              icon: FontAwesomeIcons.solidSave,
              onPressed: () async {
                Map<String, dynamic> params = Map<String, dynamic>();
                params["status_name"] = _nameStatus.toString();
                await data.addStatus(http.Client(), params);
                Navigator.pop(context);
              },
            ),
            AddingTextField(
              maxLines: 1,
              hintText: getTranslated(context, 'hint_status'),
              onChanged: (value) {
                _nameStatus = value;
              },
            ),
            // Flexible(child: AddingTextField(maxLines: 50, hintText: 'Note')),
          ],
        ),
      ),
    );
  }
}
