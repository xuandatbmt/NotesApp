import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes/models/lang.dart';
import 'package:notes/services/shared_pref.dart';
import 'package:notes/widgets/custom_appbar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'components/list_tile.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = context.watch<SharedPref>();

    void _launchURL() async {
      String url = 'https://github.com/datbmt99';
      if (await canLaunch(url))
        await launch(url);
      else
        return;
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 45),
              child: CustomAppBar(
                title: 'Settings',
                isVisible: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  SettingsListTile(
                    title: 'Night mode',
                    trailing: Transform.scale(
                      scale: 0.85,
                      child: CupertinoSwitch(
                        value: data.isNight,
                        onChanged: (value) {
                          data.enableDarkMode();
                          data.setTheme();
                        },
                      ),
                    ),
                  ),
                  SettingsListTile(
                      title: 'Languages',
                      trailing: Transform.scale(
                          scale: 0.95,
                          child: DropdownButton(
                            underline: SizedBox(),
                            icon: Icon(
                              Icons.language,
                              size: 42,
                              // color: Colors.white,
                            ),
                            items: getLanguages.map((Language lang) {
                              return new DropdownMenuItem<String>(
                                value: lang.languageCode,
                                child: new Text(lang.name),
                              );
                            }).toList(),
                            onChanged: (val) {
                              print(val);
                            },
                          ))),
                     
                  SettingsListTile(
                    title: 'Source code',
                    trailing: Transform.scale(
                      scale: 0.8,
                      child: IconButton(
                        icon: Icon(
                          FontAwesomeIcons.githubAlt,
                            color: Theme.of(context).primaryIconTheme.color,
                            size: 40
                            ),
                        onPressed: _launchURL,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
