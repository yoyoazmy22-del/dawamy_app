import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app.dart';
import 'core/constants/app_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  await Hive.initFlutter();
  await Hive.openBox(AppConstants.hiveBoxName);
  await Hive.openBox(AppConstants.hivePreferencesBox);
  await Hive.openBox(AppConstants.hiveShiftsBox);
  await Hive.openBox(AppConstants.hiveCalendarBox);

  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint('Firebase initialization skipped: $e');
  }

  runApp(
    const ProviderScope(
      child: DawamyApp(),
    ),
  );
}
