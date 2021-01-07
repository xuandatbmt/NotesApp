import 'package:flutter/material.dart';
import 'package:notes/screens/add_note/components/text_field.dart';
import 'package:notes/services/data.dart';
import 'package:notes/widgets/custom_appbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AddPrioty extends StatelessWidget {
  String _namePriority;
  @override
  Widget build(BuildContext context) {
    var data = context.watch<Data>();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            CustomAppBar(
              title: 'Add Priority',
              icon: FontAwesomeIcons.solidSave,
              onPressed: () async {
                Map<String, dynamic> params = Map<String, dynamic>();
                params["priority_name"] = _namePriority.toString();
                await data.addPriority(http.Client(), params);
                Navigator.pop(context);
              },
            ),
            AddingTextField(
              maxLines: 1,
              hintText: 'Name Priority',
              onChanged: (value) {
                _namePriority = value;
              },
            ),
          ],
        ),
      ),
    );
  }
}
