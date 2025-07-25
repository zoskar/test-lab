import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:provider/provider.dart';
import 'package:test_lab/features/connection/connection_cubit.dart';
import 'package:test_lab/features/homePage/home_page.dart';
import 'package:test_lab/features/login/auth_cubit.dart';
import 'package:test_lab/util/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const TestLabApp());
}

class TestLabApp extends StatelessWidget {
  const TestLabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => FirebaseAuth.instance),
        Provider(create: (_) => InternetConnection()),
      ],
      builder: (context, child) {
        return MultiProvider(
          providers: [
            Provider(
              create: (context) => AuthCubit(context.read<FirebaseAuth>()),
            ),
            Provider(
              create:
                  (context) => ConnectionCubit(
                    connectionChecker: context.read<InternetConnection>(),
                  ),
            ),
          ],
          child: const MaterialApp(title: 'TestLab', home: TestLabScreen()),
        );
      },
    );
  }
}
