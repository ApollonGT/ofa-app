import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

class PostContent extends StatelessWidget {
  final String title;
  final String body;
  final String link;

  const PostContent({Key? key, this.title = '', this.body = '', this.link = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            onPressed: () async {
              await launchUrl(
                Uri.parse(link),
                mode: LaunchMode.externalApplication,
                webOnlyWindowName: "_blank",
              );
            },
            icon: const Icon(
              Icons.open_in_browser,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Html(
            data: body,
          ),
        ),
      ),
    );
  }
}
