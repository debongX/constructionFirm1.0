
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomepage extends StatefulWidget {
  const MyHomepage({Key? key}) : super(key: key);

  @override
  State<MyHomepage> createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Hello"),),
    );
  }
}