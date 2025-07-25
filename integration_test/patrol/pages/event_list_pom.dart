import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:test_lab/keys.dart';

class EventListPageObject {
  EventListPageObject(this.$);

  final PatrolIntegrationTester $;

  Future<void> createNewEvent() async {
    await $(keys.eventListPage.addEventButton).tap();
  }

  Future<void> deleteEvent(String eventName) async {
    await $(
      ListTile,
    ).containing(eventName).$(keys.eventListPage.menuButton).tap();
    await $(keys.eventListPage.deleteButton).tap();
    await $(keys.eventListPage.deleteConfirmButton).tap();
  }

  Future<void> editEvent(String eventName) async {
    await $(
      ListTile,
    ).containing(eventName).$(keys.eventListPage.menuButton).tap();
    await $(keys.eventListPage.editButton).tap();
  }

  Future<void> eventNotOnTheList(String eventName) async {
    await Future.delayed(const Duration(seconds: 1), () {});
    expect($(eventName), findsNothing);
  }

  Future<void> eventIsOnTheList(String eventName) async {
    await $(ListTile).$(eventName).waitUntilVisible();
  }
}
