import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_lab/features/login/auth_cubit.dart';
import 'package:test_lab/features/connection/connection_cubit.dart';
import 'package:test_lab/features/connection/connection_tile.dart';
import 'package:test_lab/features/login/auth_tile.dart';
import 'package:test_lab/util/firebase_options.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:test_lab/widgets/placeholder_tile.dart';

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
          child: MaterialApp(title: 'TestLab', home: TestLabScreen()),
        );
      },
    );
  }
}

class TestLabScreen extends StatelessWidget {
  const TestLabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test Scenarios'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          children: [
            const AuthTile(),
            const ConnectionTile(),
            const NotificationsTile(),
            const PermissionsTile(),
            const QRCodeTile(),
            const BiometricTile(),
            const GPSTile(),
            const WebViewTile(),
            const FormsTile(),
            // const DarkModeTile(),
          ],
        ),
      ),
    );
  }
}
