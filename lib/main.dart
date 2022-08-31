import 'package:advance_course_flutter/app/app.dart';
import 'package:advance_course_flutter/app/di.dart';
import 'package:advance_course_flutter/presentation/resources/language_manger.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initAppModule();
  runApp(EasyLocalization(
      supportedLocales: const [ENGLISH_LOCAL,ARABIC_LOCAL],
      path: ASSETS_PATH_LOCALIZATION,
      child: Phoenix(child: MyApp(),),
  ));
}

