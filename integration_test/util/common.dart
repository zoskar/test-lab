import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:test_lab/data/event/event.dart';
import 'package:test_lab/data/event/event_repository.dart';
import 'package:test_lab/main.dart';
import 'package:test_lab/util/firebase_options.dart';

const nativeConfig = NativeAutomatorConfig(
  packageName: 'io.github.zoskar.testlab',
  bundleId: 'io.github.zoskar.testlab',
);

abstract class Common {
  static final EventRepository _eventRepository = EventRepository();
  static final DatabaseReference _eventsRef = FirebaseDatabase.instance
      .ref()
      .child('events');

  static Future<void> openApp(PatrolIntegrationTester $) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await $.pumpWidgetAndSettle(const TestLabApp());
  }

    static Future<void> openIntegrationApp(WidgetTester tester) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await tester.pumpWidget(const TestLabApp());
  }

  static Future<String> createTestEvent(String eventName) async {
    final eventId = 'test-${DateTime.now().millisecondsSinceEpoch}';
    final event = Event(
      name: eventName,
      eventType: 'Meetup',
      isOnline: true,
      isRecorded: false,
      guestCount: 20,
      date: '2025-04-20',
      time: '15:15',
      themeColor: const Color(0xFFFFB084),
      notificationsEnabled: false,
    );

    try {
      await _eventsRef.child(eventId).set(event.toMap());
      return eventId;
    } catch (err) {
      throw Exception('Exception when creating test event: $err');
    }
  }

  static Future<void> deleteTestEvent(String eventId) async {
    try {
      await _eventRepository.deleteEvent(eventId);
    } catch (err) {
      throw Exception('Exception when deleting test event: $err');
    }
  }

  static Future<String?> getEventIdByName(String eventName) async {
    try {
      return await _eventRepository.getEventIdByName(eventName);
    } catch (err) {
      throw Exception('Exception when getting event ID by name: $err');
    }
  }
}
