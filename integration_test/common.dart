import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:patrol/patrol.dart';
import 'package:test_lab/main.dart';
import 'package:test_lab/util/firebase_options.dart';

abstract class Common {
  static Future<void> openApp(PatrolIntegrationTester $) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await $.pumpWidgetAndSettle(const TestLabApp());
  }
}
