import 'package:flutter/material.dart';
import 'package:test_lab/features/webView/web_view.dart';
import 'package:test_lab/widgets/tile.dart';

class WebViewTile extends StatelessWidget {
  const WebViewTile({super.key});

  @override
  Widget build(BuildContext context) {
    return TLTile(
      icon: Icons.web,
      text: 'WebView',
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const WebViewPage()),
        );
      },
    );
  }
}
