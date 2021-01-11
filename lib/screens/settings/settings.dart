import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes/localization/localization_constants.dart';
import 'package:notes/main.dart';
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

    Future<void> _changeLanguage(Language language) async {
      Locale _temp = await setLocale(language.languageCode);

      MyApp.setLocale(context, _temp);
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 45),
              child: CustomAppBar(
                title: getTranslated(context, 'settings_screen'),
                isVisible: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  SettingsListTile(
                    title: getTranslated(context, 'night_mode'),
                    trailing: Transform.scale(
                      scale: 0.7,
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
                      title: getTranslated(context, 'languages'),
                      trailing: DropdownButton(
                        underline: SizedBox(),
                        icon: Icon(
                          Icons.language,
                          // color: Colors.white,
                        ),
                        items: Language.languageList()
                            .map<DropdownMenuItem<Language>>(
                                (lang) => DropdownMenuItem(
                                      value: lang,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Text(lang.flag),
                                          Text(lang.name)
                                        ],
                                      ),
                                    ))
                            .toList(),
                        onChanged: (Language language) {
                          _changeLanguage(language);
                        },
                      )),
                  SettingsListTile(
                    title: getTranslated(context, 'source_code'),
                    trailing: IconButton(
                      icon: Icon(FontAwesomeIcons.github,
                          color: Theme.of(context).primaryIconTheme.color,
                          size: 25),
                      onPressed: _launchURL,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
