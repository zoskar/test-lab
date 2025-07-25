import 'package:flutter/widgets.dart';

class _GpsPageKey extends ValueKey<String> {
  const _GpsPageKey(String value) : super('gpsPage_$value');
}

class GpsPageKeys {
  final successDialog = const _GpsPageKey('successDialog');
}
