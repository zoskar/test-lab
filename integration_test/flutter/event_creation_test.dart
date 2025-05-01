import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:test_lab/keys.dart';

import '../util/common.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  const eventName = 'UI test event creation';

  tearDown(() async {
    final eventId = await Common.getEventIdByName(eventName);
    if (eventId != null) {
      await Common.deleteTestEvent(eventId);
    }
  });

  testWidgets('tests creating event', (tester) async {
    await Common.openIntegrationApp(tester);
    await tester.tap(find.byKey(HomePageKeys.formTile));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(EventListPageKeys.addEventButton));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(EventFormKeys.nameField), eventName);
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(EventFormKeys.eventTypeDropdown));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Meetup'));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(EventFormKeys.onlineCheckbox));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(EventFormKeys.recordedCheckbox));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(EventFormKeys.dateField));
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(EventFormKeys.timeField));
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(EventFormKeys.colorPicker));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Done'));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(EventFormKeys.notificationsSwitch));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(EventFormKeys.saveButton));
    await tester.pumpAndSettle();

    expect(find.text(eventName), findsOneWidget);
  });
}
