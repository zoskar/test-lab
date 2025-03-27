import 'package:flutter/material.dart';
import 'package:test_lab/pages/connection/connection_page.dart';

class ConnectionTile extends StatelessWidget {
  const ConnectionTile({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ConnectionPage()),
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
            Icon(Icons.wifi, size: 40.0, color: Colors.blue.shade700),
            const SizedBox(height: 8.0),
            const Text(
              'Connection',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
