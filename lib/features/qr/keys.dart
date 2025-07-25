import 'package:flutter/widgets.dart';

class _QRPageKey extends ValueKey<String> {
  const _QRPageKey(String value) : super('qrPage_$value');
}

class QRPageKeys {
  final loadedImage = const _QRPageKey('loadedImage');
}
