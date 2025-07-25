import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_lab/keys.dart';

import '../util/common.dart';

void main() {
  var eventId = '';
  const eventName = 'UI test event';
  const newEventName = 'New event name';

  tearDown(() async {
    await Common.deleteTestEvent(eventId);
  });

  testWidgets('tests editing event', (tester) async {
    await Common.openIntegrationApp(tester);
    eventId = await Common.createTestEvent(eventName);

    await tester.tap(find.byKey(keys.homePage.formTile));
    await tester.pumpAndSettle();

    final listTile = find.ancestor(
      of: find.text(eventName),
      matching: find.byType(ListTile),
    );

    final menuButton = find.descendant(
      of: listTile,
      matching: find.byKey(keys.eventListPage.menuButton),
    );

    await tester.tap(menuButton);
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(keys.eventListPage.editButton));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(keys.eventFormPage.nameField), newEventName);
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(keys.eventFormPage.saveButton));
    await tester.pumpAndSettle();

    expect(find.text(newEventName), findsOneWidget);
    expect(find.text(eventName), findsNothing);
  });
}
