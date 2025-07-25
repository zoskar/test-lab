import 'package:patrol/patrol.dart';
import 'package:test_lab/keys.dart';

class EventFormPageObject {
  EventFormPageObject(this.$);

  final PatrolIntegrationTester $;

  Future<void> fillInEventDetails(String eventName) async {
    await $(keys.eventFormPage.nameField).enterText(eventName);
    await $(keys.eventFormPage.eventTypeDropdown).tap();
    await $('Meetup').tap();
    await $(keys.eventFormPage.onlineCheckbox).tap();
    await $(keys.eventFormPage.recordedCheckbox).tap();
    // TODO find a way to select the guest slider
    // await $(EventFormKeys.guestSlider)
    await $(keys.eventFormPage.dateField).tap();
    await $('OK').tap();
    await $(keys.eventFormPage.timeField).tap();
    await $('OK').tap();
    await $(keys.eventFormPage.colorPicker).tap();
    await $('Done').tap();
    await $(keys.eventFormPage.notificationsSwitch).tap();
  }

  Future<void> fillName(String name) async {
    await $(keys.eventFormPage.nameField).enterText(name);
  }

  Future<void> saveEvent() async {
    await $(keys.eventFormPage.saveButton).tap();
  }
}
