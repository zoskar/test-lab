import 'package:flutter/material.dart';
import 'tile.dart';

class FormsTile extends StatelessWidget {
  const FormsTile({super.key});

  @override
  Widget build(BuildContext context) {
    return TLTile(icon: Icons.description, text: 'Forms', onTap: () {});
  }
}

class DarkModeTile extends StatelessWidget {
  const DarkModeTile({super.key});

  @override
  Widget build(BuildContext context) {
    return TLTile(icon: Icons.dark_mode, text: 'Dark mode', onTap: () {});
  }
}

class BiometricTile extends StatelessWidget {
  const BiometricTile({super.key});

  @override
  Widget build(BuildContext context) {
    return TLTile(icon: Icons.fingerprint, text: 'Biometric', onTap: () {});
  }
}
