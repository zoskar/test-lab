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
