import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:test_lab/keys.dart';

import '../util/common.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  var eventId = '';
  const eventName = 'UI test event';

  tearDown(() async {
    await Common.deleteTestEvent(eventId);
  });

  testWidgets('tests deleting event', (tester) async {
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

    await tester.tap(find.byKey(EventListPageKeys.deleteButton));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(EventListPageKeys.deleteConfirmButton));
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 1), () {});

    expect(find.text(eventName), findsNothing);
  });
}
