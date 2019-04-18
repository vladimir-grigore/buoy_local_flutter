import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';

class FeaturedOffers extends StatelessWidget {
  List featuredOffers;
  FeaturedOffers({ Key key, this.featuredOffers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 30.0, left: 15.0, right: 15.0),
              child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                featuredOffers[index]['attributes']['image']['default'],
                fit: BoxFit.fitWidth,
              ),
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