import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:test_lab/keys.dart';

import '../util/common.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  var eventId = '';
  const eventName = 'UI test event';
  const newEventName = 'New event name';

  tearDown(() async {
    await Common.deleteTestEvent(eventId);
  });

  testWidgets('tests editing event', (tester) async {
    await Common.openIntegrationApp(tester);
    eventId = await Common.createTestEvent(eventName);

    await tester.tap(find.byKey(HomePageKeys.formTile));
    await tester.pumpAndSettle();

    final listTile = find.ancestor(
      of: find.text(eventName),
      matching: find.byType(ListTile),
    );

    final menuButton = find.descendant(
      of: listTile,
      matching: find.byKey(EventListPageKeys.menuButton),
    );

    await tester.tap(menuButton);
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(EventListPageKeys.editButton));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(EventFormKeys.nameField), newEventName);
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(EventFormKeys.saveButton));
    await tester.pumpAndSettle();

    expect(find.text(newEventName), findsOneWidget);
    expect(find.text(eventName), findsNothing);
  });
}
