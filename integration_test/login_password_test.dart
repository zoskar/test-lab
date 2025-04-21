import 'package:patrol/patrol.dart';
import 'package:test_lab/keys.dart';

import 'common.dart';
import 'pages/home_pom.dart';
import 'pages/login_pom.dart';

void main() {
  patrolTest('tests email password login', ($) async {
    final loginPage = LoginPageObject($);
    final homePage = HomePageObject($);

    await Common.openApp($);
    await homePage.openLogin();
    await loginPage.provideCredentials();
    await loginPage.logIn();
    await homePage.openLogin();
    await $('You are logged in!').waitUntilVisible();
    await $(LoginPageKeys.goBackButton).tap();
    await $('Logout').waitUntilVisible();
  });
}
