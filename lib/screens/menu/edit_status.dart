import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes/localization/localization_constants.dart';
import 'package:notes/models/status_model.dart';
import 'package:notes/services/data.dart';
import 'package:notes/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class EditStatus extends StatefulWidget {
  final String id;
  EditStatus({this.id}) : super();
  @override
  State<StatefulWidget> createState() {
    return _EditStatusState();
  }
}

class _EditStatusState extends State<EditStatus> {
  @override
  Widget build(BuildContext context) {
    var data = context.watch<Data>();
    return Scaffold(
        body: FutureBuilder(
            future: data.fetchStatusId(http.Client(), widget.id),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                return EditStatusScreen(status: snapshot.data);
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}

class EditStatusScreen extends StatefulWidget {
  final Status status;
  final String id;
  EditStatusScreen({Key key, this.status, this.id}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _EditStatusSState();
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

class _EditStatusSState extends State<EditStatusScreen> {
  bool isLoad = false;
  Status status;
  @override
  Widget build(BuildContext context) {
    var data = context.watch<Data>();
    if (isLoad == false) {
      setState(() {
        this.status = Status.fromStatusList(widget.status);
        isLoad = true;
      });
    }
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            CustomAppBar(
              title: getTranslated(context, 'edit_status_screen'),
              icon: FontAwesomeIcons.solidSave,
              onPressed: () async {
                Map<String, dynamic> params = Map<String, dynamic>();
                params["status_name"] = this.status.statusName.toString();
                if (status.statusName != '') {
                  await data.updateStatus(http.Client(), params);
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
                    hintText: getTranslated(context, 'hint_text_status')),
                controller: TextController(
                  text: this.status.statusName,
                ),
                onChanged: (text) {
                  setState(() {
                    this.status.statusName = text;
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
