import 'package:flutter/material.dart';
import 'package:notes/models/profile.dart';
import 'package:notes/services/data.dart';
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
  ProfileModel profileModel;
  @override
  Widget build(BuildContext context) {
    var data = context.watch<Data>();
    setState(() {
      if (this.isLoading == false)
        this.profileModel = ProfileModel.fromModel(widget.profileModel);
      this.isLoading = true;
    });
    //Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('User Profile', style: TextStyle(color: textColor)),
        backgroundColor: backgroundColor,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: TextField(
                          maxLines: 1,
                          decoration: InputDecoration(
                              hintText: "Email", labelText: "Email"),
                          autocorrect: false,
                          controller:
                              TextController(text: this.profileModel.email),
                          onChanged: (text) {
                            setState(() {
                              this.profileModel.email = text;
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
                              hintText: "DisplayName", labelText: "Name"),
                          controller: TextController(
                              text: this.profileModel.displayName),
                          onChanged: (text) {
                            setState(() {
                              this.profileModel.displayName = text;
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
                              params["email"] =
                                  this.profileModel.email.toString();
                              if (profileModel.displayName != '' &&
                                  profileModel.email != '') {
                                await data.updateProfile(http.Client(), params);
                                Navigator.pop(context);
                              }
                            },
                            child: Text(
                              "UPDATE",
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
          // CustomPaint(
          //   child: Container(
          //     width: MediaQuery.of(context).size.width,
          //     height: MediaQuery.of(context).size.height,
          //   ),
          //   painter: HeaderCurvedContainer(),
          // ),
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: <Widget>[
          //     Container(
          //       padding: EdgeInsets.all(20),
          //       width: MediaQuery.of(context).size.width / 3,
          //       height: MediaQuery.of(context).size.width / 3,
          //       alignment: Alignment(100, 200),
          //       decoration: BoxDecoration(
          //           border: Border.all(color: Colors.white, width: 5),
          //           shape: BoxShape.circle,
          //           color: Colors.white,
          //           image: DecorationImage(
          //             fit: BoxFit.cover,
          //             image: AssetImage('assets/images/male_avatar.png'),
          //           )),
          //     ),
          //   ],
          // ),
          // Padding(
          //   padding: EdgeInsets.only(bottom: 280, left: 28),
          //   child: Text(
          //     "Name",
          //     style: TextStyle(
          //         fontSize: 35,
          //         letterSpacing: 1.5,
          //         color: Colors.black,
          //         fontWeight: FontWeight.w500),
          //   ),
          // ),
          // Padding(
          //   padding: EdgeInsets.only(bottom: 600, left: 100),
          //   child: CircleAvatar(
          //     backgroundColor: Colors.black54,
          //     child: IconButton(
          //       icon: Icon(
          //         Icons.edit,
          //         color: Colors.white,
          //       ),
          //       onPressed: () {},
          //     ),
          //   ),
          // ),
          // SizedBox(height: size.height * 0.03),
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
