import 'package:flutter/material.dart';
import 'package:test_lab/pages/connection/connection_page.dart';
import 'package:test_lab/widgets/tile.dart';

class ConnectionTile extends StatelessWidget {
  const ConnectionTile({super.key});

  @override
  Widget build(BuildContext context) {
    return TLTile(
      icon: Icons.wifi,
      text: 'Connection',
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ConnectionPage()),
        );
      },
    );
  }
}
