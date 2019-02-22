import 'package:flutter/material.dart';

class PlaceholderPage extends StatelessWidget {
  final Color color;
  final String page_name;

  PlaceholderPage(this.color, this.page_name);

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: color,
      child: new Center(
        child: new Text(page_name),
      ),
    );
  }
}