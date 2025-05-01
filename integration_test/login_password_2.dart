import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_lab/keys.dart';
import 'package:test_lab/main.dart';
import 'package:test_lab/util/firebase_options.dart';

void main() {
  testWidgets('tests email password login', (tester) async {
    const email = 'abc@wp.pl';
    const password = 'abc@wp.pl';

    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await tester.pumpWidget(const TestLabApp());

    await tester.tap(find.byKey(HomePageKeys.loginTile));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(LoginPageKeys.loginField), email);
    await tester.enterText(find.byKey(LoginPageKeys.passwordField), password);
    await tester.tap(find.byKey(LoginPageKeys.loginButton));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(HomePageKeys.loginTile));
    await tester.pumpAndSettle();

    expect(find.text('You are logged in!'), findsOneWidget);

    await tester.tap(find.byKey(LoginPageKeys.goBackButton));
    await tester.pumpAndSettle();

    expect(find.text('Logout'), findsOneWidget);
  });
}
