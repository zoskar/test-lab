import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_lab/auth_cubit.dart';
import 'package:test_lab/firebase_options.dart';
import 'package:test_lab/pages/login_page.dart';

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
      providers: [Provider(create: (_) => FirebaseAuth.instance)],
      builder: (context, child) {
        return Provider(
          create: (_) => AuthCubit(context.read<FirebaseAuth>()),
          child: MaterialApp(title: 'TestLab', home: TestLabScreen()),
        );
      },
    );
  }
}

class TestLabScreen extends StatelessWidget {
  final List<Map<String, dynamic>> testScenarios = [
    {'title': 'Login', 'icon': Icons.login},
    {'title': 'Notifications', 'icon': Icons.notifications},
    {'title': 'Permissions', 'icon': Icons.security},
    {'title': 'QR Code', 'icon': Icons.qr_code},
    {'title': 'Biometric', 'icon': Icons.fingerprint},
    {'title': 'GPS', 'icon': Icons.location_on},
    {'title': 'WebView', 'icon': Icons.web},
    {'title': 'Dark Mode', 'icon': Icons.dark_mode},
    {'title': 'Reports', 'icon': Icons.analytics},
  ];

  TestLabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test Scenarios'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 1.0,
          ),
          itemCount: testScenarios.length,
          itemBuilder: (context, index) {
            final scenario = testScenarios[index];
            return GestureDetector(
              onTap: () {
                if (scenario['title'] == 'Login') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${scenario['title']} tapped')),
                  );
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.blue.shade300),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      scenario['icon'],
                      size: 40.0,
                      color: Colors.blue.shade700,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      scenario['title'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
