import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:buoy/model/AppState.dart';

import 'package:buoy/Components/view_model.dart';
import 'package:buoy/Components/bottom_nav.dart';

import 'package:buoy/Pages/placeholder_page.dart';
import 'package:buoy/Pages/transactions_page.dart';
import 'package:buoy/Pages/home_page.dart';
import 'package:buoy/Pages/locations_page.dart';

class AppWidget extends StatefulWidget {
  AppWidget({Key key}) : super(key: key);

  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  
  Widget get _loadingView {
    return new Center(
      child: new CircularProgressIndicator(),
    );
  }

  final List<Widget> _children = [
    HomePage(),
    LocationsPage(),
    TransactionsPage(),
    PlaceholderPage(Colors.green, "Card page"),
    PlaceholderPage(Colors.lightBlue, "More page"),
  ];

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, ViewModel>(
      converter: ViewModel.fromStore,
      builder: (BuildContext context, ViewModel vm) {
        return new Scaffold(
          body: vm.isLoading ?  _loadingView : _children[vm.tabIndex],
          bottomNavigationBar: BottomNav(),
        );
      },
    );
  }
}
