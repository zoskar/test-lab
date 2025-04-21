import 'package:flutter/widgets.dart';

class _HomePageKey extends ValueKey<String> {
  const _HomePageKey(String value) : super('homePage_$value');
}

abstract final class HomePageKeys {
  static const loginTile = _HomePageKey('lgoinTile');
}
