import 'package:flutter_test/flutter_test.dart';
import 'package:test_lab/keys.dart';

class EventFormPageObject {
  EventFormPageObject(this.tester);

  final WidgetTester tester;

  Future<void> fillInEventDetails(String eventName) async {
    await fillName(eventName);
    await tester.tap(find.byKey(keys.eventFormPage.eventTypeDropdown));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Meetup'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(keys.eventFormPage.onlineCheckbox));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(keys.eventFormPage.recordedCheckbox));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(keys.eventFormPage.dateField));
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(keys.eventFormPage.timeField));
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(keys.eventFormPage.colorPicker));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Done'));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(keys.eventFormPage.notificationsSwitch));
    await tester.pumpAndSettle();
  }

  Future<void> fillName(String name) async {
    await tester.enterText(find.byKey(keys.eventFormPage.nameField), name);
    await tester.pumpAndSettle();
  }

  Future<void> saveEvent() async {
    await tester.tap(find.byKey(keys.eventFormPage.saveButton));
    await tester.pumpAndSettle();
  }
}
