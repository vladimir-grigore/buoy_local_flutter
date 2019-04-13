import 'package:flutter/material.dart';

class OpeningHoursDropdown extends StatefulWidget{
  final List<OpenHours> openingHours;

  OpeningHoursDropdown({Key key, this.openingHours}) : super(key: key);
  
  @override
  _OpeningHoursDropdown createState() => _OpeningHoursDropdown();
}

class _OpeningHoursDropdown extends State<OpeningHoursDropdown> {
  _OpeningHoursDropdown();
  
  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          widget.openingHours[index].isExpanded = !widget.openingHours[index].isExpanded;
        });
      },
      children: widget.openingHours.map((OpenHours item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(
                item.header,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w400,
                ),
              )
            );
          },
          isExpanded: item.isExpanded,
          body: item.body,
        );
      }).toList(),
      animationDuration: Duration(milliseconds: 500),
    );
  }
}

class OpenHours {
  bool isExpanded;
  final String header;
  final Widget body;
  OpenHours(this.isExpanded, this.header, this.body);
}

