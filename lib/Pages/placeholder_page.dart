import 'package:flutter/material.dart';

class PlaceholderPage extends StatelessWidget {
  final Color color;
  final String pageName;

  PlaceholderPage(this.color, this.pageName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade700,
        title: Text(pageName),
      ),
      body: Container(
        color: color,
        child: Center(
          child: Text(pageName),
        ),
      )
    );
  }
}