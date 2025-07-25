import 'package:patrol/patrol.dart';
import 'package:test_lab/keys.dart';

class NotificationsPageObject {
  NotificationsPageObject(this.$);

  final PatrolIntegrationTester $;

  Future<void> requestPermission() async {
    await $(keys.notificationsPage.requestNotificationButton).tap();
  }

  Future<void> isOnNotificationSuccessPage() async {
    await $(keys.notificationsPage.notificationGoBackButton).waitUntilVisible();
  }
}
