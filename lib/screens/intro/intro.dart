import 'package:flutter/material.dart';
import 'package:notes/screens/home/home.dart';
import 'package:notes/screens/login/login.dart';
import 'package:notes/services/data.dart';
import 'package:notes/services/shared_pref.dart';
import 'package:notes/themes/colors.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashScreenS extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}
int state = 1;
class _SplashScreenState extends State<SplashScreenS> {
  void getDataAndGoHome() async {
    context.read<SharedPref>().getTheme();

    await Future.delayed(Duration(seconds: 2));
    // if (Data().getToken() != null && state == 1) {
    //   Navigator.of(context).pushReplacement(
    //       MaterialPageRoute(builder: (context) => HomeScreen()));
    // } else {
    //   Navigator.of(context)
    //       .pushReplacement(MaterialPageRoute(builder: (context) => Login()));
    // }
  }

  @override
  void initState() {
    super.initState();
    getDataAndGoHome();
  }

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<SharedPref>(context);

    return SplashScreen(
      // seconds: 3,
      image: Image.asset("assets/images/loading.gif"),
      photoSize: 150,
      loaderColor: Colors.blue,
    );
  }
}
