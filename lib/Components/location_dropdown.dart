import 'package:flutter/material.dart';

import 'package:buoy/api/get_offers.dart';

class LocationDropdown extends StatefulWidget {
  LocationDropdown({Key key}) : super(key: key);

  @override
  _LocationDropdown createState() => _LocationDropdown();
}

class _LocationDropdown extends State<LocationDropdown> {
  _LocationDropdown();
  String dropdownValue = 'Greater Bangor';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 20.0,
            spreadRadius: 5.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          value: dropdownValue,
          onChanged: (String newValue) {
            setState(() {
              dropdownValue = newValue;
            });
            getOffers(location: newValue);
          },
          isExpanded: true,
          items: <String>[
            'Aroostook', 'Downeast & Acadia', 'Kennebec & Moose River Valleys',
            'Maine Highlands', 'Maine Lakes & Mountains', 'Mid-Coast',
            'South Coast', 'Greater Bangor', 'Greater Portland'
          ].map((String value) {
            return DropdownMenuItem(
              value: value,
              child: Text(value, style: TextStyle(fontSize: 20.0)),
            );
          }).toList(),
        ),
      ),
      
      

    );
  }
}