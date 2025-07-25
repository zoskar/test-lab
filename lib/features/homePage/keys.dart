import 'package:flutter/widgets.dart';

class _HomePageKey extends ValueKey<String> {
  const _HomePageKey(String value) : super('homePage_$value');
}

class HomePageKeys {
  final loginTile = const _HomePageKey('loginTile');
  final notificationsTile = const _HomePageKey('notificationsTile');
  final qrTile = const _HomePageKey('qrTile');
  final webViewTile = const _HomePageKey('webViewTile');
  final gpsTile = const _HomePageKey('gpsTile');
  final connectionTile = const _HomePageKey('connectionTile');
  final formTile = const _HomePageKey('formTile');
}

// Z dokumentu

// class _HomePageKey extends ValueKey<String> {
//   const _HomePageKey(String value) : super('homePage_$value');
// }
// class HomePageKeys {
//   final menuIconButton = const _HomePageKey('menuIconButton');
// }
