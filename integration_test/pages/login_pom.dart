import 'package:patrol/patrol.dart';
import 'package:test_lab/keys.dart';

class LoginPageObject {
  LoginPageObject(this.$);

  final PatrolIntegrationTester $;

  Future<void> provideCredentials() async {
    const email = String.fromEnvironment('LOGIN_EMAIL');
    const password = String.fromEnvironment('LOGIN_PASSWORD');

    await $(LoginPageKeys.loginField).enterText(email);
    await $(LoginPageKeys.passwordField).enterText(password);
  }

  Future<void> googleLogIn() async {
    await $(LoginPageKeys.googleSignInButton).tap();
    // TODO use selector instead of text
    await $.native2.tap(
      NativeSelector(android: AndroidSelector(text: 'Andrzej Strzelba')),
    );
  }

  Future<void> logIn() async {
    await $(LoginPageKeys.loginButton).tap();
  }

  Future<void> checkIfLoggedIn() async {
    await $('You are logged in!').waitUntilVisible();
    await $(LoginPageKeys.goBackButton).tap();
    await $('Logout').waitUntilVisible();
  }
}
