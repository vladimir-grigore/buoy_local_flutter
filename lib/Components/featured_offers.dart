import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';

class FeaturedOffers extends StatelessWidget {
  final List featuredOffers;
  FeaturedOffers({ Key key, this.featuredOffers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 30.0, left: 15.0, right: 15.0),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    featuredOffers[index]['attributes']['image']['default'],
                    fit: BoxFit.fitWidth,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.center,
                        colors: [Colors.black.withOpacity(0.5), Colors.black.withOpacity(0.0)],
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  padding: EdgeInsets.only(left: 25.0, bottom: 25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        featuredOffers[index]['attributes']['merchant-name'],
                        style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        featuredOffers[index]['attributes']['title'],
                        style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                      ), 
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        autoplay: featuredOffers.length > 1 ? true : false,
        indicatorLayout: PageIndicatorLayout.COLOR,
        itemCount: featuredOffers.length,
        pagination: featuredOffers.length > 1 ? SwiperPagination() : null,
        scale: 0.7,
        onTap: (index) {},
      ),
    );
  }
}
