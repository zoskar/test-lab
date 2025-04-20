import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:patrol/patrol.dart';
import 'package:test_lab/main.dart';
import 'package:test_lab/util/firebase_options.dart';

void main() {
  patrolTest('test', ($) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await $.pumpWidgetAndSettle(const TestLabApp());

    await $('Login').tap();
  });
}
