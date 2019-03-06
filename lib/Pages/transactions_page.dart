import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:buoy/model/AppState.dart';
import 'package:buoy/api/get_transactions.dart';

class TransactionsPage extends StatelessWidget {
  final Color color;

  TransactionsPage(this.color);

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: color,
      child: new Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Transactions page"),
            StoreConnector<AppState, GetTransactions>(
              converter: (store) => () => store.dispatch(getTransactions),
              builder: (_, getTransactionsCallback) {
                return RaisedButton(
                  onPressed: () {getTransactionsCallback();},
                  child: Text("Get Transactions"),
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}

typedef void GetTransactions();
