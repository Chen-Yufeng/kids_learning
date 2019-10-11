import 'package:flutter/material.dart';

class StaticPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StaticState();
  }
}

class _StaticState extends State<StaticPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('StaticPage'),
    );
  }
}