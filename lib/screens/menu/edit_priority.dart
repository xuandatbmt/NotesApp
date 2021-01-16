import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes/localization/localization_constants.dart';
import 'package:notes/models/priority_model.dart';
import 'package:notes/services/data.dart';
import 'package:notes/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class EditPriority extends StatefulWidget {
  final String id;
  EditPriority({this.id}) : super();
  @override
  State<StatefulWidget> createState() {
    return _EditPriorityState();
  }
}

class _EditPriorityState extends State<EditPriority> {
  @override
  Widget build(BuildContext context) {
    var data = context.watch<Data>();
    return Scaffold(
        body: FutureBuilder(
            future: data.fetchPriorityId(http.Client(), widget.id),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                return EditPriorityScreen(priority: snapshot.data);
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}

class EditPriorityScreen extends StatefulWidget {
  final Priority priority;
  final String id;
  EditPriorityScreen({Key key, this.priority, this.id}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _EditPrioritySState();
  }
}

class TextController extends TextEditingController {
  TextController({String text}) {
    this.text = text;
  }

  set text(String newText) {
    value = value.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
        composing: TextRange.empty);
  }
}

class _EditPrioritySState extends State<EditPriorityScreen> {
  bool isLoad = false;
  Priority priority;
  @override
  Widget build(BuildContext context) {
    var data = context.watch<Data>();
    if (isLoad == false) {
      setState(() {
        this.priority = Priority.fromPriorityList(widget.priority);
        isLoad = true;
      });
    }
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            CustomAppBar(
              title: getTranslated(context, 'edit_priority_screen'),
              icon: FontAwesomeIcons.solidSave,
              onPressed: () async {
                Map<String, dynamic> params = Map<String, dynamic>();
                params["id"] = this.priority.id;
                params["priority_name"] = this.priority.priorityName.toString();
                if (priority.priorityName != null) {
                  await data.updatePriority(http.Client(), params);
                  Navigator.pop(context);
                  data.update();
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                maxLines: 1,
                autocorrect: false,
                decoration: InputDecoration(
                    hintText: getTranslated(context, 'hint_text_priority')),
                controller: TextController(
                  text: this.priority.priorityName,
                ),
                onChanged: (text) {
                  setState(() {
                    this.priority.priorityName = text;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
