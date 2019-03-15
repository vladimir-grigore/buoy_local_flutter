import 'package:flutter/material.dart';

import 'package:buoy/api/get_transactions.dart';

class TransactionsPage extends StatefulWidget {
  TransactionsPage({Key key}) : super(key: key);

  @override
  _TransactionsPage createState() => _TransactionsPage();
}

class _TransactionsPage extends State<TransactionsPage> {

  _TransactionsPage();

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
      future: getTransactions(context),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.hasData) {
          if(snapshot.data != null) {
            var transactions  = snapshot.data['data'];

            return new Container(
              child: ListView.builder (
                itemCount: transactions.length,
                padding: EdgeInsets.all(8.0),
                itemBuilder: (BuildContext context, int index) {
                  if(transactions != null) {
                    return Card(
                      child:Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text("${transactions[index]['attributes']['merchant-name']}"),
                      ),
                    );
                  }
                },
              ),
            );
          }
        } else {
          return new Center(
            child: new CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
