import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

import '../util/common.dart';
import 'pages/home_pom.dart';
import 'pages/login_pom.dart';

void main() {
  testWidgets('tests email password login', (tester) async {
    final homePage = HomePageObject(tester);
    final loginPage = LoginPageObject(tester);

    await dotenv.load(fileName: '.patrol.env');
    final email = dotenv.env['LOGIN_EMAIL']!;
    final password = dotenv.env['LOGIN_PASSWORD']!;

    await Common.openIntegrationApp(tester);

    await homePage.openLogin();
    await loginPage.provideCredentials(email: email, password: password);
    await loginPage.logIn();

    await homePage.openLogin();
    await loginPage.checkIfLoggedIn();
  });
}
