import 'package:flutter/material.dart';
import 'package:test_lab/features/connection/connection_page.dart';
import 'package:test_lab/keys.g.dart';
import 'package:test_lab/widgets/tile.dart';

class ConnectionTile extends StatelessWidget {
  const ConnectionTile({super.key});

  @override
  Widget build(BuildContext context) {
    return TLTile(
      key: HomePageKeys.connectionTile,
      icon: Icons.wifi,
      text: 'Connection',
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(builder: (context) => const ConnectionPage()),
        );
      },
    );
  }
}
