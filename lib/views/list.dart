import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../models/post.dart';
import './content.dart';

class ListPosts extends StatefulWidget {
  final String base;
  final String title;

  const ListPosts({Key? key, required this.base, required this.title})
      : super(key: key);

  @override
  State<ListPosts> createState() => _ListPostsState();
}

class _ListPostsState extends State<ListPosts> {
  String baseURL = '';
  String fullURL = '';
  int page = 1;
  bool loading = false;
  List<Post> posts = [];

  void updateFullURL() {
    setState(() {
      fullURL = baseURL + '?page=' + page.toString();
    });
  }

  ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();

    baseURL = widget.base + '/wp-json/wp/v2/posts/';
    page = 1;
    fullURL = baseURL + '?page=' + page.toString();

    controller.addListener(_scrollListener);
    _fetchPosts(fullURL);
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (controller.position.extentAfter < 200 && !loading) {
      setState(() {
        loading = true;
        page = page + 1;
      });
      updateFullURL();
      _fetchPosts(fullURL);
    }
  }

  Future<List<Post>> _fetchPosts(String url) async {
    List<Post> ret = await fetchPosts(url);
    setState(() {
      loading = false;
      posts.addAll(ret);
    });
    return ret;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        controller: controller,
        padding: const EdgeInsets.all(8.0),
        itemCount: posts.length,
        itemBuilder: (BuildContext ctx, int idx) {
          Post post = posts[idx];
          return Card(
            child: ListTile(
              // leading: const FlutterLogo(size: 72.0),
              title: Html(
                data: post.title,
                style: {
                  "*": Style(
                    fontWeight: FontWeight.bold,
                    fontSize: FontSize.large,
                  ),
                },
              ),
              subtitle: Html(
                data: post.excerpt,
              ),
              trailing: GestureDetector(
                child: const Icon(Icons.open_in_new),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PostContent(
                        title: post.title,
                        body: post.content,
                        link: post.link,
                      ),
                    ),
                  );
                },
              ),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}
