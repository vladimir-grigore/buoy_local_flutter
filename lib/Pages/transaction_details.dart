import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:buoy/Components/view_model.dart';
import 'package:buoy/Components/buoy_header.dart';
import 'package:buoy/model/AppState.dart';
import 'package:buoy/api/get_active_transaction.dart';
import 'package:buoy/Pages/receipt_page.dart';
import 'package:buoy/Pages/feedback_page.dart';

class TransactionDetailsPage extends StatelessWidget {
  final index;
  TransactionDetailsPage(this.index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade700,
        title: Text("Transaction Details"),
      ),
      body: StoreConnector<AppState, ViewModel>(
        converter: ViewModel.fromStore,
        builder: (BuildContext context, ViewModel vm) {
          if(vm.activeTransaction != null 
            && vm.transactions[index]['id'] == vm.activeTransaction['data']['id']) {
            return TransactionDetails(index);
          } else {
            return FutureBuilder(
              future: getActiveTransaction(vm.transactions[index]['id']),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if(snapshot.hasData) {
                  if(snapshot.data != null) {
                    return TransactionDetails(index);
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}

class TransactionDetails extends StatelessWidget {
  final int index;
  TransactionDetails(this.index);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      converter: ViewModel.fromStore,
      builder: (BuildContext context, ViewModel vm) {
        return  Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              BuoyHeader(),
              Flexible(
                flex: 1,
                child: Container(
                  child: DefaultTabController(
                    length: 2,
                    child: Scaffold(
                      backgroundColor: Colors.indigo.shade700,
                      appBar: TabBar(
                        labelColor: Colors.white,
                        indicatorColor: Colors.white,
                        tabs: <Widget>[
                          Tab(text: "RECEIPT"),
                          Tab(text: "FEEDBACK"),
                        ],
                      ),
                      body: TabBarView(
                        children: <Widget>[
                          ReceiptPage(),
                          FeedbackPage(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}