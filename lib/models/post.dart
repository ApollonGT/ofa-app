import 'dart:convert';
import 'package:http/http.dart' as http;

class Post {
  final int id;
  final String date;
  final String status;
  final String link;
  final String title;
  final String content;
  final String excerpt;

  const Post({
    required this.id,
    required this.date,
    required this.status,
    required this.link,
    required this.title,
    required this.content,
    required this.excerpt,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    String excerpt = json['excerpt']['rendered'];
    if (excerpt.length > 10) {
      excerpt = excerpt.split("<p>")[1].split("<a")[0];
    }

    String content = json['content']['rendered'];
    if (content.length > 10) {
      content = content.split('<figure class="wp-block-embed')[0];
    }

    return Post(
      id: json['id'],
      date: json['date_gmt'],
      status: json['status'],
      link: json['link'],
      title: json['title']['rendered'],
      content: content,
      excerpt: excerpt,
    );
  }
}

Future<List<Post>> fetchPosts(String url) async {
  List<Post> result = [];
  final response = await http.get(Uri.parse(url));
  List<dynamic> body = [];

  if (response.statusCode == 200) {
    body = jsonDecode(response.body);
    for (var element in body) {
      result.add(Post.fromJson(element));
    }

    return result;
  } else {
    throw Exception('Failed to load album');
  }
}
