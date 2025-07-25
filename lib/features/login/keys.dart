import 'package:flutter/widgets.dart';

class _LoginPageKey extends ValueKey<String> {
  const _LoginPageKey(String value) : super('loginPage_$value');
}

class LoginPageKeys {
  final loginField = const _LoginPageKey('loginField');
  final passwordField = const _LoginPageKey('passwordField');
  final loginButton = const _LoginPageKey('loginButton');
  final googleSignInButton = const _LoginPageKey('googleSignInButton');
  final goBackButton = const _LoginPageKey('goBackButton');
  final logoutButton = const _LoginPageKey('logoutButton');
}
