import 'package:patrol/patrol.dart';
import 'package:test_lab/keys.dart';

class EventFormPageObject {
  EventFormPageObject(this.$);

  final PatrolIntegrationTester $;

  Future<void> fillInEventDetails(String eventName) async {
    await $(EventFormKeys.nameField).enterText(eventName);
    await $(EventFormKeys.eventTypeDropdown).tap();
    await $('Meetup').tap();
    await $(EventFormKeys.onlineCheckbox).tap();
    await $(EventFormKeys.recordedCheckbox).tap();
    // TODO find a way to select the guest slider
    // await $(EventFormKeys.guestSlider)
    await $(EventFormKeys.dateField).tap();
    await $('OK').tap();
    await $(EventFormKeys.timeField).tap();
    await $('OK').tap();
    await $(EventFormKeys.colorPicker).tap();
    await $('Done').tap();
    await $(EventFormKeys.notificationsSwitch).tap();
  }

  Future<void> fillName(String name) async {
    await $(EventFormKeys.nameField).enterText(name);
  }

  Future<void> saveEvent() async {
    await $(EventFormKeys.saveButton).tap();
  }
}
