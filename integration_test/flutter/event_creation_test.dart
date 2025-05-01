import 'package:flutter_test/flutter_test.dart';

import '../util/common.dart';
import 'pages/event_form_pom.dart';
import 'pages/event_list_pom.dart';
import 'pages/home_pom.dart';

void main() {
  const eventName = 'UI test event creation';

  tearDown(() async {
    final eventId = await Common.getEventIdByName(eventName);
    if (eventId != null) {
      await Common.deleteTestEvent(eventId);
    }
  });

  testWidgets('tests creating event', (tester) async {
    await Common.openIntegrationApp(tester);

    final homePage = HomePageObject(tester);
    final eventListPage = EventListPageObject(tester);
    final eventFormPage = EventFormPageObject(tester);

    await homePage.openForm();
    await eventListPage.createNewEvent();
    await eventFormPage.fillInEventDetails(eventName);
    await eventFormPage.saveEvent();

    await eventListPage.verifyEventIsOnTheList(eventName);
  });
}
