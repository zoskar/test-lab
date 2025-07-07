import 'package:flutter_test/flutter_test.dart';
import 'package:test_lab/keys.g.dart';

class LoginPageObject {
  LoginPageObject(this.tester);

  final WidgetTester tester;

  Future<void> provideCredentials({
    required String email,
    required String password,
  }) async {
    await tester.enterText(find.byKey(LoginPageKeys.loginField), email);
    await tester.enterText(find.byKey(LoginPageKeys.passwordField), password);
  }

  Future<void> logIn() async {
    await tester.tap(find.byKey(LoginPageKeys.loginButton));
    await tester.pumpAndSettle();
  }

  Future<void> goBack() async {
    await tester.tap(find.byKey(LoginPageKeys.goBackButton));
    await tester.pumpAndSettle();
  }

  Future<void> checkIfLoggedIn() async {
    expect(find.text('You are logged in!'), findsOneWidget);
    await goBack();
    expect(find.text('Logout'), findsOneWidget);
  }
}
