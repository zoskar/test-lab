import 'package:flutter/widgets.dart';

final widgetKeys = WidgetKeys();

class _WidgetKey extends ValueKey<String> {
  const _WidgetKey(String value) : super('WidgetKeys-$value');
}

class WidgetKeys {
  final tile = const _WidgetKey('tile');
}
