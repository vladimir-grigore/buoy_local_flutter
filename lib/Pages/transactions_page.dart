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
    return Scaffold(
      appBar: AppBar(
        title: Text("Transactions"),
      ),
      body: FutureBuilder(
        future: getTransactions(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.hasData) {    
            if(snapshot.data != null) {
              var transactions  = snapshot.data['data'];

              return Container(
                child: ListView.builder (
                  itemCount: transactions.length,
                  itemBuilder: (BuildContext context, int index) {
                    if(transactions != null) {
                      return TransactionListItem(transactions:transactions, index: index);
                    }
                  },
                ),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
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
                child: Text(formatDate(index, "EEEE MMMM d, y")),
              ),
            ),
          ),
          _transaction(),
        ],
      );
    } else {
      return _transaction();
    }
  }

  Widget _transaction () {
    var amount = NumberFormat.currency(locale: "en_US", symbol: "\$");
    var type = transactions[index]['attributes']['reversal'] ? "Refund" : "Payment";

    return Card(
      child: InkWell(
        onTap: () => { print("Transaction row tapped") },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                        Text(
                          "${transactions[index]['attributes']['merchant-name']}",
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(formatDate(index, "jm")),
                    ],
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                        Text(amount.format(transactions[index]['attributes']['amount']['cents']/100)),
                        Text(type),
                    ],
                  ),
                  Icon(Icons.chevron_right),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool shouldDisplayHeader(index) {
    if(index > 0) {
      if(formatDate(index, "EEEE MMMM d, y")  == formatDate(index - 1, "EEEE MMMM d, y")) {
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }

  String formatDate(index, format) {
    var transactionDate = transactions[index]['attributes']['created-at'];
    DateTime date = DateTime.parse(transactionDate);
    String formattedDate = DateFormat(format).format(date);
    return formattedDate;
  }
}
