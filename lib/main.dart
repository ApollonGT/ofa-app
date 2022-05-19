import 'package:flutter/material.dart';
import 'package:ofa/views/list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Όμιλος Φίλων Αστρονομίας',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: const ListPosts(
          title: 'Όμιλος Φίλων Αστρονομίας', base: 'https://www.ofa.gr'),
      debugShowCheckedModeBanner: false,
    );
  }
}
