import 'package:flutter/widgets.dart';

class TestKey extends ValueKey<String> {
  const TestKey(super.value);
}

final class HomePageKeys {
  const HomePageKeys();

  static const loginTile = TestKey('homePage_loginTile');
  static const notificationsTile = TestKey('homePage_notificationsTile');
  static const qrTile = TestKey('homePage_qrTile');
  static const webViewTile = TestKey('homePage_webViewTile');
  static const gpsTile = TestKey('homePage_gpsTile');
  static const connectionTile = TestKey('homePage_connectionTile');
  static const formTile = TestKey('homePage_formTile');
}

final class LoginPageKeys {
  const LoginPageKeys();

  static const loginField = TestKey('loginPage_loginField');
  static const passwordField = TestKey('loginPage_passwordField');
  static const loginButton = TestKey('loginPage_loginButton');
  static const googleSignInButton = TestKey('loginPage_googleSignInButton');
  static const goBackButton = TestKey('loginPage_goBackButton');
  static const logoutButton = TestKey('loginPage_logoutButton');
}

final class ConnectionPageKeys {
  const ConnectionPageKeys();

  static const connectedStatus = TestKey('connectionPage_connectedStatus');
  static const disconnectedStatus = TestKey('connectionPage_disconnectedStatus');
}

final class NotificationsPageKeys {
  const NotificationsPageKeys();

  static const requestNotificationButton = TestKey('notificationsPage_requestNotificationButton');
  static const notificationGoBackButton = TestKey('notificationsPage_notificationGoBackButton');
}

final class QrPageKeys {
  const QrPageKeys();

  static const loadedImage = TestKey('qrPage_loadedImage');
}

final class GpsPageKeys {
  const GpsPageKeys();

  static const successDialog = TestKey('gpsPage_successDialog');
}

final class EventFormKeys {
  const EventFormKeys();

  static const nameField = TestKey('eventForm_nameField');
  static const eventTypeDropdown = TestKey('eventForm_eventTypeDropdown');
  static const onlineCheckbox = TestKey('eventForm_onlineCheckbox');
  static const recordedCheckbox = TestKey('eventForm_recordedCheckbox');
  static const guestSlider = TestKey('eventForm_guestSlider');
  static const dateField = TestKey('eventForm_dateField');
  static const timeField = TestKey('eventForm_timeField');
  static const colorPicker = TestKey('eventForm_colorPicker');
  static const notificationsSwitch = TestKey('eventForm_notificationsSwitch');
  static const saveButton = TestKey('eventForm_saveButton');
}

final class EventListPageKeys {
  const EventListPageKeys();

  static const refreshIndicator = TestKey('eventListPage_refreshIndicator');
  static const addEventButton = TestKey('eventListPage_addEventButton');
  static const editButton = TestKey('eventListPage_editButton');
  static const deleteButton = TestKey('eventListPage_deleteButton');
  static const deleteConfirmButton = TestKey('eventListPage_deleteConfirmButton');
  static const menuButton = TestKey('eventListPage_menuButton');
}
