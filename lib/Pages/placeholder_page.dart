import 'package:flutter/material.dart';

class PlaceholderPage extends StatelessWidget {
  final Color color;
  final String pageName;

  PlaceholderPage(this.color, this.pageName);

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: color,
      child: new Center(
        child: new Text(pageName),
      ),
    );
  }
}