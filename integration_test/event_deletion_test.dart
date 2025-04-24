import 'package:patrol/patrol.dart';
import 'pages/event_list_pom.dart';
import 'pages/home_pom.dart';
import 'util/common.dart';

void main() {
  var eventId = '';
  const eventName = 'UI test event';

  patrolTearDown(() async {
    await Common.deleteTestEvent(eventId);
  });
  patrolTest('test deleting event', ($) async {
    final homePage = HomePageObject($);
    final eventList = EventListPageObject($);

    eventId = await Common.createTestEvent(eventName);
    await Common.openApp($);
    await homePage.openForm();
    await eventList.deleteEvent(eventName);
    await eventList.eventNotOnTheList(eventName);
  });
}
