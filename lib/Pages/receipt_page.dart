import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:buoy/model/AppState.dart';
import 'package:buoy/Components/view_model.dart';

class ReceiptPage extends StatelessWidget {
  ReceiptPage();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      converter: ViewModel.fromStore,
      builder: (BuildContext context, ViewModel vm) {
        return Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              _innerHeader(context, vm),
              _merchantDetails(context, vm),
              _paymentDetails(context, vm),
            ],
          ),
        );
      },
    );

  }

  Widget _innerHeader(BuildContext context,ViewModel vm) {
    var transaction = vm.activeTransaction['data']['attributes'];

    if(transaction['points'] > 0 && !transaction['reversal']) {
      return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(15.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          border:Border.all(color: Colors.grey),
        ),
        child: Column(
          children: <Widget>[
            Text("YOU EARNED"),
            Text("${transaction['points']} Points",
              style: TextStyle(fontSize: 30, color: Colors.indigo.shade700, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      );
    } else if(transaction['acquisition-amount']['cents'] > 0 && !transaction['reversal']) {
      return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(15.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          border:Border.all(color: Colors.grey),
        ),
        child: Column(
          children: <Widget>[
            Text("YOU SAVED"),
            Text(transaction['acquisition-amount']['cents'],
              style: TextStyle(fontSize: 30, color: Colors.indigo.shade700, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _merchantDetails(BuildContext context, ViewModel vm) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(transactionDate(vm.activeTransaction['data']['attributes']['created-at']),
              style: TextStyle(fontSize: 12.0, color: Colors.grey)
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(vm.activeTransaction['included'][0]['attributes']['name'],
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.0)
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(vm.activeTransaction['included'][0]['attributes']['address']),
          ),
          Divider(),
        ],
      ),
    );
  }

  Widget _paymentDetails(BuildContext context, ViewModel vm) {
    List<Map> receiptRows = [];
    var currencyFormat = NumberFormat.currency(locale: "en_US", symbol: "\$");

    if((vm.activeTransaction['data']['attributes']['credit-card-amount']['cents']).abs() > 0 && 
        vm.activeTransaction['data']['attributes']['credit-card-last-4'] != null) {
      var cardNumStr = "Amount";

      if(vm.activeTransaction['data']['attributes']['credit-card-last-4'].toString() != "") {
        cardNumStr = vm.activeTransaction['data']['attributes']['credit-card-brand'] + " ••" + vm.activeTransaction['data']['attributes']['credit-card-last-4'];
      }
      var returnObj = {
        "title": cardNumStr, "amount": vm.activeTransaction['data']['attributes']['credit-card-amount']['cents'] / -100
      };

      receiptRows.add(returnObj);
    }

    if((vm.activeTransaction['data']['attributes']['merchant-fund-amount']['cents']).abs() > 0) {
      var returnObj = {
        "title": "Buoy Bucks", "amount": vm.activeTransaction['data']['attributes']['merchant-fund-amount']['cents'] / -100
      };

      receiptRows.add(returnObj);
    }

    if((vm.activeTransaction['data']['attributes']['acquisition-amount']['cents']).abs() > 0) {
      var returnObj = {
        "title": "Amount Discounted", 
        "amount": vm.activeTransaction['data']['attributes']['acquisition-amount']['cents'] / -100
      };

      receiptRows.add(returnObj);
    }

    if((vm.activeTransaction['data']['attributes']['points']).abs() > 0 && vm.activeTransaction['data']['attributes']['reversal']) {
      var returnObj = {
        "title": "Points Deducted", 
        "amount": vm.activeTransaction['data']['attributes']['points']
      };

      receiptRows.add(returnObj);
    }

    if((vm.activeTransaction['data']['attributes']['tip-amount']['cents']).abs() > 0) {
      var returnObj = {
        "title": "Tip", 
        "amount": vm.activeTransaction['data']['attributes']['tip-amount']['cents'] / 100
      };

      receiptRows.add(returnObj);
    }

    receiptRows.add({
      "title": vm.activeTransaction['data']['attributes']['reversal'] ? "Total Refund" : "Total Payment",
      "amount": vm.activeTransaction['data']['attributes']['amount']['cents'] / 100
    });

    return Container(
      child: Expanded(
        child: ListView.builder(
          itemCount: receiptRows.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(receiptRows[index]['title']),
                  ),
                  Text(currencyFormat.format(receiptRows[index]['amount'])),            
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  String transactionDate(date) {
    DateTime parsedDate = DateTime.parse(date);
    String transactionDate = DateFormat("MMMM d, y").add_jm().format(parsedDate);
    return transactionDate;
  }
}
