import 'package:flutter/widgets.dart';

class _HomePageKey extends ValueKey<String> {
  const _HomePageKey(String value) : super('homePage_$value');
}

abstract final class HomePageKeys {
  static const loginTile = _HomePageKey('loginTile');
  static const notificationsTile = _HomePageKey('notificationsTile');
  static const qrTile = _HomePageKey('qrTile');
  static const webViewTile = _HomePageKey('webViewTile');
  static const gpsTile = _HomePageKey('gpsTile');
  static const connectionTile = _HomePageKey('connectionTile');
  static const formTile = _HomePageKey('formTile');
}

class _LoginPageKey extends ValueKey<String> {
  const _LoginPageKey(String value) : super('loginPage_$value');
}

abstract final class LoginPageKeys {
  static const loginField = _LoginPageKey('loginField');
  static const passwordField = _LoginPageKey('passwordField');
  static const loginButton = _LoginPageKey('loginButton');
  static const googleSignInButton = _LoginPageKey('googleSignInButton');
  static const goBackButton = _LoginPageKey('goBackButton');
  static const logoutButton = _LoginPageKey('logoutButton');
}

class _ConnectionPageKey extends ValueKey<String> {
  const _ConnectionPageKey(String value) : super('connectionPage_$value');
}

abstract final class ConnectionPageKeys {
  static const connectedStatus = _ConnectionPageKey('connectedStatus');
  static const disconnectedStatus = _ConnectionPageKey('disconnectedStatus');
}

class _NotificationsPageKey extends ValueKey<String> {
  const _NotificationsPageKey(String value) : super('notificationsPage_$value');
}

abstract final class NotificationsPageKeys {
  static const requestNotificationButton = _NotificationsPageKey(
    'requestNotificationButton',
  );
  static const notificationGoBackButton = _NotificationsPageKey(
    'notificationGoBackButton',
  );
}

class _QRPageKey extends ValueKey<String> {
  const _QRPageKey(String value) : super('qrPage_$value');
}

abstract final class QRPageKeys {
  static const loadedImage = _QRPageKey('loadedImage');
}

class _GpsPageKey extends ValueKey<String> {
  const _GpsPageKey(String value) : super('gpsPage_$value');
}

abstract final class GpsPageKeys {
  static const successDialog = _GpsPageKey('successDialog');
}

class _EventFormPageKey extends ValueKey<String> {
  const _EventFormPageKey(String value) : super('eventForm_$value');
}

abstract final class EventFormKeys {
  static const nameField = _EventFormPageKey('nameField');
  static const eventTypeDropdown = _EventFormPageKey('eventTypeDropdown');
  static const onlineCheckbox = _EventFormPageKey('onlineCheckbox');
  static const recordedCheckbox = _EventFormPageKey('recordedCheckbox');
  static const guestSlider = _EventFormPageKey('guestSlider');
  static const dateField = _EventFormPageKey('dateField');
  static const timeField = _EventFormPageKey('timeField');
  static const colorPicker = _EventFormPageKey('colorPicker');
  static const notificationsSwitch = _EventFormPageKey('notificationsSwitch');
  static const saveButton = _EventFormPageKey('saveButton');
}

class _EventListPageKey extends ValueKey<String> {
  const _EventListPageKey(String value) : super('eventList_$value');
}

abstract final class EventListPageKeys {
  static const refreshIndicator = _EventListPageKey('refreshIndicator');
  static const addEventButton = _EventListPageKey('addEventButton');
  static const editButton = _EventListPageKey('editButton');
  static const deleteButton = _EventListPageKey('deleteButton');
  static const deleteConfirmButton = _EventListPageKey('deleteConfirmButton');
  static const menuButton = _EventListPageKey('menuButton');
}
