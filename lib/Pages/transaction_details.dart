import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:buoy/Components/view_model.dart';
import 'package:buoy/model/AppState.dart';

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
          return  Container(
            color: Colors.cyan,
            child: Center(
              child: Text("${vm.transactions[index]}"),
            ),
          );
        },
      ),
    );
  }
}