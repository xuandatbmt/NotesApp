import 'package:flutter/material.dart';
import 'package:notes/localization/localization_constants.dart';
import 'package:notes/models/profile.dart';
import 'package:notes/services/data.dart';
import 'package:notes/services/shared_pref.dart';
import 'package:notes/themes/colors.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class UserProfileScreen extends StatefulWidget {
  final ProfileModel profileModel;
  UserProfileScreen({Key key, this.profileModel}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _UserProfileScreenState();
  }
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var data = context.watch<Data>();
    return Scaffold(
        body: FutureBuilder(
            future: data.getProfile(http.Client()),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                return UserProfile(profileModel: snapshot.data);
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}

class UserProfile extends StatefulWidget {
  final ProfileModel profileModel;
  const UserProfile({Key key, this.profileModel}) : super(key: key);
  @override
  _UserProfilePage createState() => _UserProfilePage();
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

class _UserProfilePage extends State<UserProfile> {
  bool isLoading = false;
  String _newPassWord;
  ProfileModel profileModel;
  @override
  Widget build(BuildContext context) {
    var data = context.watch<Data>();
    var theme = context.watch<SharedPref>();
    setState(() {
      if (this.isLoading == false)
        this.profileModel = ProfileModel.fromModel(widget.profileModel);
      this.isLoading = true;
    });
    //Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        brightness: theme.isNight ? Brightness.dark : Brightness.light,
        elevation: 0.0,
        title: Text(getTranslated(context, 'user_profile'),
            style: TextStyle(color: fabSplashColor)),
        backgroundColor: Colors.white10,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        //  / alignment: AlignmentDirectional.center,
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 450,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: TextField(
                          maxLines: 1,
                          enabled: false,
                          decoration: InputDecoration(
                              labelText: getTranslated(context, 'email')),
                          controller:
                              TextController(text: this.profileModel.email),
                          autocorrect: false,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: TextField(
                          maxLines: 1,
                          autocorrect: false,
                          decoration: InputDecoration(
                              hintText:
                                  getTranslated(context, 'hint_text_email'),
                              labelText: getTranslated(context, 'email_text')),
                          controller: TextController(
                              text: this.profileModel.displayName),
                          onChanged: (text) {
                            setState(() {
                              this.profileModel.displayName = text;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: TextField(
                          maxLines: 1,
                          autocorrect: false,
                          decoration: InputDecoration(
                              hintText:
                                  getTranslated(context, 'email_password'),
                              labelText:
                                  getTranslated(context, 'email_password')),
                          onChanged: (text) {
                            setState(() {
                              _newPassWord = text;
                            });
                          },
                        ),
                      ),
                      Container(
                        height: 55,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(29),
                          child: FlatButton(
                            // padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                            color: Colors.blue,
                            onPressed: () async {
                              Map<String, dynamic> params =
                                  Map<String, dynamic>();
                              params["displayName"] =
                                  this.profileModel.displayName.toString();
                              this.profileModel.toString();
                              if (_newPassWord != '') {
                                params["password"] = _newPassWord.toString();
                              }
                              if (profileModel.displayName != '') {
                                await data.updateProfile(http.Client(), params);
                                Navigator.pop(context);
                              }
                            },
                            child: Text(
                              getTranslated(context, 'email_update'),
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.blue[200];
    Path path = Path()
      ..relativeLineTo(0, 60)
      ..quadraticBezierTo(size.width / 2, 100, size.width, 60)
      ..relativeLineTo(0, -60)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
