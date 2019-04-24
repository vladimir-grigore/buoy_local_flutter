import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'package:buoy/model/AppState.dart';
import 'package:buoy/Components/view_model.dart';

class FeedbackPage extends StatefulWidget {
  FeedbackPage({Key key}) : super(key: key);

  @override
  _FeedbackPage createState() => _FeedbackPage();
}

class _FeedbackPage extends State<FeedbackPage> {
  var rating = 0.0;
  _FeedbackPage();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      converter: ViewModel.fromStore,
      builder: (BuildContext context, ViewModel vm) {
        if(vm.activeTransaction['data']['attributes']['has-sent-feedback']) {
          return Container(
            color: Colors.white,
            padding: EdgeInsets.all(30.0),
            child: Column(
              children: <Widget>[
                Icon(Icons.check_circle, color: Colors.green, size: 70),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text("Thank you for your feedback"),
                ),
              ],
            ),
            
          );
        } else {
          return Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: ListView(
              padding: EdgeInsets.only(top: 10.0),
              children: <Widget>[
                Text("What do you thing of ${vm.activeTransaction['data']['attributes']['merchant-name']}?"),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: SmoothStarRating(
                    allowHalfRating: false,
                    onRatingChanged: (val) {
                      rating = val;
                      setState(() {
                        rating = val;
                        //TODO: implement API call for rating
                      });
                    },
                    starCount: 5,
                    rating: rating,
                    size: 50.0,
                    color: Colors.indigo.shade700,
                    borderColor: Colors.grey,
                  ),
                ),
                TextField(
                  maxLines: 6,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Write about your experience here and it will go directly to those in charge!"
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: RaisedButton(
                    onPressed: (){
                      //TODO: implement API call for rating
                    },
                    color: Theme.of(context).accentColor,
                    textColor: Colors.white,
                    disabledTextColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                    child: Text("SEND FEEDBACK", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300)),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
