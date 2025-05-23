import 'package:patrol/patrol.dart';

import '../util/common.dart';
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
    await loginPage.checkIfLoggedIn();
  });
}
