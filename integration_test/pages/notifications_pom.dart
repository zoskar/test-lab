import 'package:patrol/patrol.dart';
import 'package:test_lab/keys.dart';

class NotificationsPageObject {
  NotificationsPageObject(this.$);

  final PatrolIntegrationTester $;

  Future<void> requestPermission() async {
    await $(NotificationsPageKeys.requestNotificationButton).tap();
  }

  Future<void> isOnNotificationSuccessPage() async {
    await $(NotificationsPageKeys.notificationGoBackButton).waitUntilVisible();
  }
}
