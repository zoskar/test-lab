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
