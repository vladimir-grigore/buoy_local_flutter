import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
      future: getTransactions(),
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
                    return TransactionListItem(transactions:transactions, index: index);
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

class TransactionListItem extends StatelessWidget {
  final List transactions;
  final int index;

  TransactionListItem({Key key, this.transactions, this.index}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    if(shouldDisplayHeader(index)) {
      return Column(
        children: <Widget>[
          Card(
            color: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Text("${formatDate(index)}"),
              ),
            ),
          ),
          Card(
            child:Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Text("${transactions[index]['attributes']['merchant-name']}"),
              ),
            ),
          )
        ],
      );
    } else {
      return Card(
        child:Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Text("${transactions[index]['attributes']['merchant-name']}"),
          ),
        ),
      );
    }
  }

  shouldDisplayHeader(index) {
    if(index > 0) {
      if(formatDate(index)  == formatDate(index - 1)) {
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }

  formatDate(index) {
    var transactionDate = transactions[index]['attributes']['created-at'];
    DateTime date = DateTime.parse(transactionDate);
    String formattedDate = DateFormat("EEEE MMMM d, y").format(date);
    return formattedDate;
  }

}