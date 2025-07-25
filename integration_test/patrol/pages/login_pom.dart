import 'package:patrol/patrol.dart';
import 'package:test_lab/keys.dart';

class LoginPageObject {
  LoginPageObject(this.$);

  final PatrolIntegrationTester $;

  Future<void> provideCredentials() async {
    const email = String.fromEnvironment('LOGIN_EMAIL');
    const password = String.fromEnvironment('LOGIN_PASSWORD');

    await $(keys.loginPage.loginField).enterText(email);
    await $(keys.loginPage.passwordField).enterText(password);
  }

  Future<void> googleLogIn() async {
    await $(
      keys.loginPage.googleSignInButton,
    ).tap(settlePolicy: SettlePolicy.noSettle);
    await $.native2.tap(
      NativeSelector(android: AndroidSelector(text: 'Andrzej Strzelba')),
    );
  }

  Future<void> logIn() async {
    await $(keys.loginPage.loginButton).tap();
  }

  Future<void> checkIfLoggedIn() async {
    await $('You are logged in!').waitUntilVisible();
    await $(keys.loginPage.goBackButton).tap();
    await $('Logout').waitUntilVisible();
  }
}
