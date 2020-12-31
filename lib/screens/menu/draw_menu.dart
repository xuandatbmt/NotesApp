import 'package:flutter/material.dart';
import 'package:notes/screens/menu/about.dart';
import 'package:notes/screens/menu/notify.dart';
import 'package:notes/screens/menu/rate_and_review.dart';
import 'package:notes/screens/menu/user_info.dart';
import 'package:notes/screens/settings/settings.dart';

class OptionMenu extends StatefulWidget {
  @override
  _OptionMenuState createState() => _OptionMenuState();
}

class _OptionMenuState extends State<OptionMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              //width: double.infinity,
              padding: EdgeInsets.all(20),
              color: Colors.blue[500],
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserProfile(),
                          ),
                        );
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        margin: EdgeInsets.only(top: 30, bottom: 5),
                        decoration: (BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image:
                                  AssetImage('assets/images/male_avatar.png'),
                              fit: BoxFit.cover),
                        )),
                      ),
                    ),
                    // Container(
                    //   width: 150,
                    //   height: 50,
                    //   margin: EdgeInsets.only(top: 30, bottom: 5),
                    //   child: ClipRRect(
                    //     borderRadius: BorderRadius.circular(20),
                    //     child: FlatButton(
                    //       // padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                    //       color: Colors.white,
                    //       onPressed: () {},
                    //       child: Text(
                    //         "Đăng xuất",
                    //         style: TextStyle(fontSize: 20, color: Colors.black),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            new Divider(),
            ListTile(
              leading: Icon(Icons.circle_notifications),
              title: Text(
                'Notify',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Notify(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(
                'Setting',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsScreen(),
                  ),
                );
              },
            ),
            new Divider(),
            ListTile(
              leading: Icon(Icons.category),
              title: Text(
                'Category',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                //  Navigator.pushNamed(context, '/settings');
              },
            ),
            ListTile(
              leading: Icon(Icons.low_priority),
              title: Text(
                'Prioty',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                //  Navigator.pushNamed(context, '/settings');
              },
            ),
            ListTile(
              leading: Icon(Icons.bar_chart),
              title: Text(
                'Statistics',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                //  Navigator.pushNamed(context, '/settings');
              },
            ),
            new Divider(),
            ListTile(
              leading: Icon(Icons.mail),
              title: Text(
                'Support Us',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text(
                'Rate and Review',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RateandReview(),
                  ),
                );
              },
            ),
            new Divider(),
            ListTile(
              leading: Icon(Icons.info),
              title: Text(
                'About',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => About(),
                  ),
                );
              },
            ),
            new Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text(
                'Logout',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
