import 'package:common_ui/widgets/tile.dart';
import 'package:flutter/material.dart';
import 'package:test_lab/features/webView/web_view.dart';
import 'package:test_lab/keys.dart';

class WebViewTile extends StatelessWidget {
  const WebViewTile({super.key});

  @override
  Widget build(BuildContext context) {
    return TLTile(
      key: keys.homePage.webViewTile,
      icon: Icons.web,
      text: 'WebView',
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(builder: (context) => const WebViewPage()),
        );
      },
    );
  }
}
