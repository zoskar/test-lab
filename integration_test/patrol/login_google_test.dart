import 'dart:io';

import 'package:patrol/patrol.dart';

import '../util/common.dart';
import 'pages/home_pom.dart';
import 'pages/login_pom.dart';

void main() {
  // Google login cannot be tested on iOS simulator
  if (Platform.isAndroid) {
    patrolTest('tests Google login', ($) async {
      final loginPage = LoginPageObject($);
      final homePage = HomePageObject($);

      await Common.openApp($);
      await homePage.openLogin();
      await loginPage.googleLogIn();
      await homePage.openLogin();
      await loginPage.checkIfLoggedIn();
    });
  }
}
