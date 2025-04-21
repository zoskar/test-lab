import 'package:patrol/patrol.dart';
import 'common.dart';
import 'pages/home_pom.dart';
import 'pages/notifications_pom.dart';

void main() {
  patrolTest('tests push notifications', ($) async {
    final homePage = HomePageObject($);
    final notificationPage = NotificationsPageObject($);

    await Common.openApp($);
    await homePage.openNotifications();
    await notificationPage.requestPermission();
    await $.native.grantPermissionWhenInUse();

    // await notificationPage.requestPermission();
    // await $.nativeAutomator2.tapOnNotificationByIndex(0);
    // await notificationPage.isOnNotificationSuccessPage();
  });
}
