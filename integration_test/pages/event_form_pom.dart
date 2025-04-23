import 'package:flutter/material.dart';
import 'package:patrol/patrol.dart';
import 'package:test_lab/keys.dart';

class EventFormPageObject {
  EventFormPageObject(this.$);

  final PatrolIntegrationTester $;

  Future<void> fillInEventDetails() async {
    await $(EventFormKeys.nameField).enterText('Test Event');
    await $(EventFormKeys.eventTypeDropdown).tap();
    await $(DropdownMenuItem).at(0).tap();
    await $(EventFormKeys.onlineCheckbox).tap();
    await $(EventFormKeys.recordedCheckbox).tap();
    // await $(EventFormKeys.guestSlider)
    await $(EventFormKeys.dateField).tap();
    await $('Ok').tap();
    await $(EventFormKeys.timeField).tap();
    await $('Ok').tap();
    await $(EventFormKeys.colorPicker).tap();
    await $('Done').tap();
    await $(EventFormKeys.notificationsSwitch).tap();
  }

  Future<void> saveEvent() async {
    await $(EventFormKeys.saveButton).tap();
  }
}
