import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class WatchHandler {
  static void watch(BuildContext context, String getMoviesList) {
    if (getMoviesList.isEmpty) return;

    final url = getMoviesList.trim();

    if (_isYoutube(url)) {
      _openYoutube(url);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => _WebViewPage(url: url)),
      );
    }
  }

  static bool _isYoutube(String url) {
    return url.contains("youtube.com") || url.contains("youtu.be");
  }

  static Future<void> _openYoutube(String url) async {
    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

class _WebViewPage extends StatefulWidget {
  final String url;

  const _WebViewPage({required this.url});

  @override
  State<_WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<_WebViewPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    _controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("Watch")),
      body: WebViewWidget(controller: _controller),
    );
  }
}
