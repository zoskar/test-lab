import 'package:flutter/widgets.dart';

class _ConnectionPageKey extends ValueKey<String> {
  const _ConnectionPageKey(String value) : super('connectionPage_$value');
}

class ConnectionPageKeys {
  final connectedStatus = const _ConnectionPageKey('connectedStatus');
  final disconnectedStatus = const _ConnectionPageKey('disconnectedStatus');
}
