import 'package:flutter/widgets.dart';

class _NotificationsPageKey extends ValueKey<String> {
  const _NotificationsPageKey(String value) : super('notificationsPage_$value');
}

class NotificationsPageKeys {
  final requestNotificationButton = const _NotificationsPageKey(
    'requestNotificationButton',
  );
  final notificationGoBackButton = const _NotificationsPageKey(
    'notificationGoBackButton',
  );
}
