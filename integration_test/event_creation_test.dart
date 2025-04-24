import 'package:patrol/patrol.dart';
import 'pages/event_form_pom.dart';
import 'pages/event_list_pom.dart';
import 'pages/home_pom.dart';
import 'util/common.dart';

void main() {
  // TODO find a way to retrieve the eventId
  var eventId = '';
  const eventName = 'UI test event creation';

  patrolTearDown(() async {
    // TODO uncomment this when the eventId is retrieved
    // await Common.deleteTestEvent(eventId);
  });
  patrolTest('test creating event', ($) async {
    final homePage = HomePageObject($);
    final eventList = EventListPageObject($);
    final eventForm = EventFormPageObject($);

    await Common.openApp($);
    await homePage.openForm();
    await eventList.createNewEvent();
    await eventForm.fillInEventDetails(eventName);
    await eventForm.saveEvent();
    await eventList.eventIsOnTheList(eventName);
  });
}
