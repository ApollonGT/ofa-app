import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class PostContent extends StatelessWidget {
  final String title;
  final String body;
  final String link;

  const PostContent({Key? key, this.title = '', this.body = '', this.link = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(body);
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
          child: body.isNotEmpty
              ? HtmlWidget(
                  body,
                  customStylesBuilder: (element) {
                    if (element.localName == 'div') {
                      return {'padding-top': '20px'};
                    }
                    if (element.localName == 'p') {
                      return {'padding-top': '10px'};
                    }

                    return null;
                  },
                )
              : const Text("hi"),
        ),
      ),
    );
  }
}
