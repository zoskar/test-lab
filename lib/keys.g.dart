import 'package:flutter/widgets.dart';

class _HomePageKey extends ValueKey<String> {
  const _HomePageKey(String value) : super('homePage_$value');
}

class _LoginPageKey extends ValueKey<String> {
  const _LoginPageKey(String value) : super('loginPage_$value');
}

class _ConnectionPageKey extends ValueKey<String> {
  const _ConnectionPageKey(String value) : super('connectionPage_$value');
}

class _NotificationsPageKey extends ValueKey<String> {
  const _NotificationsPageKey(String value) : super('notificationsPage_$value');
}

class _QrPageKey extends ValueKey<String> {
  const _QrPageKey(String value) : super('qrPage_$value');
}

class _GpsPageKey extends ValueKey<String> {
  const _GpsPageKey(String value) : super('gpsPage_$value');
}

class _EventFormKey extends ValueKey<String> {
  const _EventFormKey(String value) : super('eventForm_$value');
}

class _EventListPageKey extends ValueKey<String> {
  const _EventListPageKey(String value) : super('eventListPage_$value');
}

final class HomePageKeys {
  const HomePageKeys();

  static const loginTile = _HomePageKey('loginTile');
  static const notificationsTile = _HomePageKey('notificationsTile');
  static const qrTile = _HomePageKey('qrTile');
  static const webViewTile = _HomePageKey('webViewTile');
  static const gpsTile = _HomePageKey('gpsTile');
  static const connectionTile = _HomePageKey('connectionTile');
  static const formTile = _HomePageKey('formTile');
}

final class LoginPageKeys {
  const LoginPageKeys();

  static const loginField = _LoginPageKey('loginField');
  static const passwordField = _LoginPageKey('passwordField');
  static const loginButton = _LoginPageKey('loginButton');
  static const googleSignInButton = _LoginPageKey('googleSignInButton');
  static const goBackButton = _LoginPageKey('goBackButton');
  static const logoutButton = _LoginPageKey('logoutButton');
}

final class ConnectionPageKeys {
  const ConnectionPageKeys();

  static const connectedStatus = _ConnectionPageKey('connectedStatus');
  static const disconnectedStatus = _ConnectionPageKey('disconnectedStatus');
}

final class NotificationsPageKeys {
  const NotificationsPageKeys();

  static const requestNotificationButton = _NotificationsPageKey('requestNotificationButton');
  static const notificationGoBackButton = _NotificationsPageKey('notificationGoBackButton');
}

final class QrPageKeys {
  const QrPageKeys();

  static const loadedImage = _QrPageKey('loadedImage');
}

final class GpsPageKeys {
  const GpsPageKeys();

  static const successDialog = _GpsPageKey('successDialog');
}

final class EventFormKeys {
  const EventFormKeys();

  static const nameField = _EventFormKey('nameField');
  static const eventTypeDropdown = _EventFormKey('eventTypeDropdown');
  static const onlineCheckbox = _EventFormKey('onlineCheckbox');
  static const recordedCheckbox = _EventFormKey('recordedCheckbox');
  static const guestSlider = _EventFormKey('guestSlider');
  static const dateField = _EventFormKey('dateField');
  static const timeField = _EventFormKey('timeField');
  static const colorPicker = _EventFormKey('colorPicker');
  static const notificationsSwitch = _EventFormKey('notificationsSwitch');
  static const saveButton = _EventFormKey('saveButton');
}

final class EventListPageKeys {
  const EventListPageKeys();

  static const refreshIndicator = _EventListPageKey('refreshIndicator');
  static const addEventButton = _EventListPageKey('addEventButton');
  static const editButton = _EventListPageKey('editButton');
  static const deleteButton = _EventListPageKey('deleteButton');
  static const deleteConfirmButton = _EventListPageKey('deleteConfirmButton');
  static const menuButton = _EventListPageKey('menuButton');
}
