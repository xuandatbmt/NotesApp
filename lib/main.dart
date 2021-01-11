// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:notes/localization/demo_localization.dart';
import 'package:notes/screens/login/login.dart';
import 'package:notes/services/data.dart';
import 'package:notes/services/shared_pref.dart';
import 'package:provider/provider.dart';
import 'themes/dark_theme.dart';
import 'themes/light_theme.dart';

Future main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(
    MultiProvider(
      child: MyApp(),
      providers: [
        ChangeNotifierProvider(create: (context) => Data()),
        ChangeNotifierProvider(
          create: (context) => SharedPref(),
        ),
      ],
    ),
  );
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(locale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    var data = context.watch<SharedPref>();

    return MaterialApp(
      title: 'Notes Management',
      home: Login(),
      locale: _locale,
      supportedLocales: [
        Locale('en', 'GB'),
        Locale('vi', 'VN'),
        Locale('fr', 'FR'),
      ],
      localizationsDelegates: [
        DemoLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        for (var locale in supportedLocales) {
          if (locale.languageCode == deviceLocale.languageCode &&
              locale.countryCode == deviceLocale.countryCode) {
            return deviceLocale;
          }
        }

        return supportedLocales.first;
      },
      theme: data.isNight ? darkTheme : lightTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}
