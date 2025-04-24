import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:patrol/patrol.dart';
import 'package:test_lab/main.dart';
import 'package:test_lab/util/firebase_options.dart';

const nativeConfig = NativeAutomatorConfig(
  packageName: 'io.github.zoskar.testlab',
  bundleId: 'io.github.zoskar.testlab',
);

abstract class Common {
  static Future<void> openApp(PatrolIntegrationTester $) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await $.pumpWidgetAndSettle(const TestLabApp());
  }

  static Future<String> createTestEvent(String eventName) async {
    const url =
        'https://test-lab-a4a12-default-rtdb.europe-west1.firebasedatabase.app/events.json';
    final eventId = 'test-${DateTime.now().millisecondsSinceEpoch}';
    final Map<String, dynamic> eventData = {
      eventId: {
        'date': '2025-04-20',
        'eventType': 'Meetup',
        'guestCount': 20,
        'isOnline': true,
        'isRecorded': false,
        'name': eventName,
        'notificationsEnabled': false,
        'themeColor': 4293467747,
        'time': '15:15',
      },
    };

    try {
      final response = await http.patch(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(eventData),
      );

      if (response.statusCode != 200) {
        throw Exception(
          'Failed to create event. Status: ${response.statusCode}, Body: ${response.body}',
        );
      }
      return eventId;
    } catch (err) {
      throw Exception('Exception when creating test event: $err');
    }
  }

  static Future<void> deleteTestEvent(String eventId) async {
    final url =
        'https://test-lab-a4a12-default-rtdb.europe-west1.firebasedatabase.app/events/$eventId.json';
    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode != 200) {
        throw Exception(
          'Failed to delete event. Status: ${response.statusCode}, Body: ${response.body}',
        );
      }
    } catch (err) {
      throw Exception('Exception when deleting test event: $err');
    }
  }
}
