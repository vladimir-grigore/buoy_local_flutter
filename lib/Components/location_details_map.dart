import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

class LocationDetailsMap extends StatefulWidget {
  final PlacesDetailsResponse place;
  final double height;

  LocationDetailsMap({Key key, this.place, this.height}) : super(key: key);

  @override
  _LocationDetailsMap createState() => _LocationDetailsMap();
}

class _LocationDetailsMap extends State<LocationDetailsMap> {
  Completer<GoogleMapController> _controller = Completer();
  bool isLoading = false;
  String errorLoading;
  PlacesDetailsResponse place;
  Set<Marker> marker = {};
  LatLng center;

  void addMarker() {
    final location = widget.place.result.geometry.location;
    final center = LatLng(location.lat, location.lng);

    marker.add(
      Marker(
        markerId: MarkerId(place.hashCode.toString()),
        position: center,
        infoWindow: InfoWindow(
          title: widget.place.result.name,
          snippet: widget.place.result.formattedAddress,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      )
    );

    setState(() {
      this.marker = marker;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    addMarker();
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    final location = widget.place.result.geometry.location;
    final center = LatLng(location.lat, location.lng);
    
    return SizedBox(
      height: widget.height,
      child: GoogleMap(
        onMapCreated: _onMapCreated,
        markers: marker,
        initialCameraPosition: CameraPosition(
          target: center, zoom: 15.0,
        ),
      ),
    );
  }
}
