import 'package:flutter/material.dart';
import 'package:notes/localization/demo_localization.dart';


String getTranslated(BuildContext context, String key) {
  return DemoLocalization.of(context).getTranslatedValues(key);
}
