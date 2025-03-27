import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_lab/pages/login/auth_cubit.dart';
import 'package:test_lab/pages/connection/connection_cubit.dart';
import 'package:test_lab/pages/connection/connection_tile.dart';
import 'package:test_lab/pages/login/auth_tile.dart';
import 'package:test_lab/firebase_options.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(TestLabApp());
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
            AuthTile(),
            ConnectionTile(),
            NotificationsTile(),
            PermissionsTile(),
            QRCodeTile(),
            BiometricTile(),
            GPSTile(),
            WebViewTile(),
            DarkModeTile(),
            FormsTile(),
          ],
        ),
      ),
    );
  }
}

class FormsTile extends StatelessWidget {
  const FormsTile({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildPlaceholderTile('Forms', Icons.description);
  }
}

class NotificationsTile extends StatelessWidget {
  const NotificationsTile({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildPlaceholderTile('Notifications', Icons.notifications);
  }
}

class PermissionsTile extends StatelessWidget {
  const PermissionsTile({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildPlaceholderTile('Permissions', Icons.security);
  }
}

class QRCodeTile extends StatelessWidget {
  const QRCodeTile({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildPlaceholderTile('QR Code', Icons.qr_code);
  }
}

class BiometricTile extends StatelessWidget {
  const BiometricTile({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildPlaceholderTile('Biometric', Icons.fingerprint);
  }
}

class GPSTile extends StatelessWidget {
  const GPSTile({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildPlaceholderTile('GPS', Icons.location_on);
  }
}

class WebViewTile extends StatelessWidget {
  const WebViewTile({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildPlaceholderTile('WebView', Icons.web);
  }
}

class DarkModeTile extends StatelessWidget {
  const DarkModeTile({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildPlaceholderTile('Dark Mode', Icons.dark_mode);
  }
}

// Helper method to build placeholder tiles
Widget _buildPlaceholderTile(String title, IconData icon) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.blue.shade100,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.blue.shade300),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 40.0, color: Colors.blue.shade700),
        const SizedBox(height: 8.0),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}
