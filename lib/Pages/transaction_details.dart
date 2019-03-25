import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:buoy/Components/view_model.dart';
import 'package:buoy/model/AppState.dart';
import 'package:buoy/api/get_active_transaction.dart';

class TransactionDetails extends StatelessWidget {
  final index;
  TransactionDetails(this.index);

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
          return FutureBuilder(
            future: getActiveTransaction(vm.transactions[index]['id']),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if(snapshot.hasData) {
                if(snapshot.data != null) {
                  return  Container(
                    color: Colors.cyan,
                    child: Column(
                      children: <Widget>[
                        Text("Transaction", 
                          style: TextStyle(fontSize: 30),
                        ),
                        Center(
                          child: Text("${vm.transactions[index]}"),
                        ),
                        Text("Active Transaction", 
                          style: TextStyle(fontSize: 30),
                        ),
                        Center(
                          child: Text("${vm.activeTransaction}"),
                        ),
                      ],
                    ),
                  );
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          );

        },
      ),
    );
  }
}