import 'package:flutter_test/flutter_test.dart';
import '../util/common.dart';
import 'pages/event_list_pom.dart';
import 'pages/home_pom.dart';

void main() {
  var eventId = '';
  const eventName = 'UI test event';

  tearDown(() async {
    await Common.deleteTestEvent(eventId);
  });

  testWidgets('tests deleting event', (tester) async {
    await Common.openIntegrationApp(tester);
    eventId = await Common.createTestEvent(eventName);

    final homePage = HomePageObject(tester);
    final eventListPage = EventListPageObject(tester);

    await homePage.openForm();
    await eventListPage.deleteEvent(eventName);
    await eventListPage.verifyEventNotOnTheList(eventName);
  });
}
