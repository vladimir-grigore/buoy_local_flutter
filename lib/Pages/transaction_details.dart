import 'package:flutter/material.dart';

class TransactionDetails extends StatelessWidget {
  TransactionDetails();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transaction Details"),
      ),
      body: Container(
        color: Colors.cyan,
        child: Center(
          child: Text("Transactions Details Page"),
        ),
      ),
    );
  }
}