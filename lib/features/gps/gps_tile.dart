import 'package:flutter/material.dart';
import 'package:test_lab/features/gps/gps_page.dart';
import 'package:test_lab/keys.dart';
import 'package:test_lab/widgets/tile.dart';

class GPSTile extends StatelessWidget {
  const GPSTile({super.key});

  @override
  Widget build(BuildContext context) {
    return TLTile(
      key: HomePageKeys.gpsTile,
      icon: Icons.location_on,
      text: 'GPS',
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(builder: (context) => const GPSPage()),
        );
      },
    );
  }
}
