import 'package:flutter/material.dart';
import 'package:test_lab/features/form/event_list_page.dart';
import 'package:test_lab/widgets/tile.dart';

class FormsTile extends StatelessWidget {
  const FormsTile({super.key});

  @override
  Widget build(BuildContext context) {
    return TLTile(
      icon: Icons.description,
      text: 'Forms',
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(builder: (context) => const EventListPage()),
        );
      },
    );
  }
}
