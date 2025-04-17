import 'package:flutter/material.dart';

class FormSuccessPage extends StatelessWidget {
  const FormSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form Submitted')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 80,
            ),
            const SizedBox(height: 24),
            const Text(
              'Form Submitted Successfully',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Your event has been successfully created.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed:
                  () =>
                      Navigator.of(context).popUntil(ModalRoute.withName('/')),
              child: const Text('Return to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
