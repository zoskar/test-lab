import 'dart:io';

import 'package:patrol/patrol.dart';

import '../util/common.dart';
import 'pages/home_pom.dart';
import 'pages/notifications_pom.dart';

void main() {
  patrolTest('tests push notifications', ($) async {
    final homePage = HomePageObject($);
    final notificationPage = NotificationsPageObject($);

    await Common.openApp($);
    await homePage.openNotifications();
    await $.native2.grantPermissionWhenInUse();
    await notificationPage.requestPermission();
    await $.native2.closeHeadsUpNotification();
    await $.native2.openNotifications();
    // TODO: Sort out index inconsistency
    if (Platform.isIOS) {
      await $.native2.tapOnNotificationByIndex(1);
    } else {
      await $.native2.tapOnNotificationByIndex(0);
    }
    await notificationPage.isOnNotificationSuccessPage();
  });
}
