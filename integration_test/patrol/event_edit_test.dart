import 'package:patrol/patrol.dart';

import '../util/common.dart';
import 'pages/event_form_pom.dart';
import 'pages/event_list_pom.dart';
import 'pages/home_pom.dart';

void main() {
  var eventId = '';
  const eventName = 'UI test event';
  const newEventName = 'New event name';

  patrolTearDown(() async {
    await Common.deleteTestEvent(eventId);
  });

  patrolTest('test editing event', ($) async {
    final homePage = HomePageObject($);
    final eventList = EventListPageObject($);
    final eventForm = EventFormPageObject($);

    await Common.openApp($);
    eventId = await Common.createTestEvent(eventName);
    await homePage.openForm();
    await eventList.editEvent(eventName);
    await eventForm.fillName(newEventName);
    await eventForm.saveEvent();
    await eventList.eventIsOnTheList(newEventName);
    await eventList.eventNotOnTheList(eventName);
  });
}
