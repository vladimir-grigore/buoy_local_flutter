import 'package:flutter/material.dart';

class LearnMoreModal extends StatelessWidget{
  LearnMoreModal({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: (){
        showDialog(
          context: context,
          builder: (_) => SimpleDialog(
            contentPadding: EdgeInsets.all(20),
            title: Icon(Icons.star_border, color: Colors.grey, size: 50),
            children: <Widget>[
              Center(
                child: Text("Redeeming Points", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "You can redeem your points into Buoy Bucks that can be used at any participating location.",
                  style: TextStyle(color: Colors.black45),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                    onPressed: (){Navigator.of(context).pop();},
                    child: Text("COOL, I GET IT!", style: TextStyle(color: Colors.indigo[700])),
                  ),
                ],
              ),
            ],
          ),
        );
      },
      child: Text("LEARN MORE", style: TextStyle(color: Colors.indigo[700])),
    );
  }
}