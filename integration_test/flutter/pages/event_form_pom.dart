import 'package:flutter_test/flutter_test.dart';
import 'package:test_lab/keys.dart';

class EventFormPageObject {
  EventFormPageObject(this.tester);

  final WidgetTester tester;

  Future<void> fillInEventDetails(String eventName) async {
    await fillName(eventName);
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
  }

  Future<void> fillName(String name) async {
    await tester.enterText(find.byKey(EventFormKeys.nameField), name);
    await tester.pumpAndSettle();
  }

  Future<void> saveEvent() async {
    await tester.tap(find.byKey(EventFormKeys.saveButton));
    await tester.pumpAndSettle();
  }
}
