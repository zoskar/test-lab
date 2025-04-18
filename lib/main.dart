import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:provider/provider.dart';
import 'package:test_lab/features/connection/connection_cubit.dart';
import 'package:test_lab/features/connection/connection_tile.dart';
import 'package:test_lab/features/form/form_tile.dart';
import 'package:test_lab/features/gps/gps_tile.dart';
import 'package:test_lab/features/login/auth_cubit.dart';
import 'package:test_lab/features/login/auth_tile.dart';
import 'package:test_lab/features/notifications/notifications_tile.dart';
import 'package:test_lab/features/qr/qr_tile.dart';
import 'package:test_lab/features/webView/web_view_tile.dart';
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

class TestLabScreen extends StatelessWidget {
  const TestLabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test Scenarios'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          children: const [
            AuthTile(),
            ConnectionTile(),
            WebViewTile(),
            NotificationsTile(),
            QRCodeTile(),
            GPSTile(),
            FormsTile(),
          ],
        ),
      ),
    );
  }
}
