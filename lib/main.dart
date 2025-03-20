import 'package:flutter/material.dart';

void main() {
  runApp(TestLabApp());
}

class TestLabApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'TestLab', home: TestLabScreen());
  }
}

class TestLabScreen extends StatelessWidget {
  // List of test scenarios
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test Scenarios'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // Number of tiles in a row
            crossAxisSpacing: 8.0, // Horizontal spacing between tiles
            mainAxisSpacing: 8.0, // Vertical spacing between tiles
            childAspectRatio: 1.0, // Ensures square tiles
          ),
          itemCount: testScenarios.length,
          itemBuilder: (context, index) {
            final scenario = testScenarios[index];
            return GestureDetector(
              onTap: () {
                // Placeholder for future functionality
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${scenario['title']} tapped')),
                );
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
