import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_lab/keys.dart';

class EventListPageObject {
  EventListPageObject(this.tester);

  final WidgetTester tester;

  Future<void> createNewEvent() async {
    await tester.tap(find.byKey(EventListPageKeys.addEventButton));
    await tester.pumpAndSettle();
  }

  Future<void> deleteEvent(String eventName) async {
    final eventFinder = find.ancestor(
      of: find.text(eventName),
      matching: find.byType(ListTile),
    );

    await tester.tap(
      find.descendant(
        of: eventFinder,
        matching: find.byKey(EventListPageKeys.menuButton),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(EventListPageKeys.deleteButton));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(EventListPageKeys.deleteConfirmButton));
    await tester.pumpAndSettle();
  }

  Future<void> editEvent(String eventName) async {
    final eventFinder = find.ancestor(
      of: find.text(eventName),
      matching: find.byType(ListTile),
    );

    await tester.tap(
      find.descendant(
        of: eventFinder,
        matching: find.byKey(EventListPageKeys.menuButton),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(EventListPageKeys.editButton));
    await tester.pumpAndSettle();
  }

  Future<void> verifyEventNotOnTheList(String eventName) async {
    await Future.delayed(const Duration(seconds: 1), () {});
    expect(find.text(eventName), findsNothing);
  }

  Future<void> verifyEventIsOnTheList(String eventName) async {
    expect(find.text(eventName), findsOneWidget);
  }
}
