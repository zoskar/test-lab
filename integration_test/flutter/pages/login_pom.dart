import 'package:flutter_test/flutter_test.dart';
import 'package:test_lab/keys.dart';

class LoginPageObject {
  LoginPageObject(this.tester);

  final WidgetTester tester;

  Future<void> provideCredentials({
    required String email,
    required String password,
  }) async {
    await tester.enterText(find.byKey(keys.loginPage.loginField), email);
    await tester.enterText(find.byKey(keys.loginPage.passwordField), password);
  }

  Future<void> logIn() async {
    await tester.tap(find.byKey(keys.loginPage.loginButton));
    await tester.pumpAndSettle();
  }

  Future<void> goBack() async {
    await tester.tap(find.byKey(keys.loginPage.goBackButton));
    await tester.pumpAndSettle();
  }

  Future<void> checkIfLoggedIn() async {
    expect(find.text('You are logged in!'), findsOneWidget);
    await goBack();
    expect(find.text('Logout'), findsOneWidget);
  }
}
