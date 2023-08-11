import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_app/core/models/region_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class GoogleMapView extends StatefulWidget {
  static const route = 'GoogleMapView';
  GoogleMapView({
    super.key,
    required this.select,
    this.lat,
    this.lon,
    required this.locations,
  });
  final bool select;
  var lat;
  var lon;
  List<RegionModel> locations = [];

  @override
  State<GoogleMapView> createState() => _GoogleMapViewState();
}

class _GoogleMapViewState extends State<GoogleMapView> {
  Position? cl;

  CameraPosition? _kGooglePlex;
  Set<Marker> _markers = {};

  Future getPosition() async {
    bool services;
    LocationPermission permeation;

    services = await Geolocator.isLocationServiceEnabled();
    log(services.toString());
    if (services == false) {
      // do any thing if you wont;
    }

    permeation = await Geolocator.checkPermission();
    if (permeation == LocationPermission.denied) {
      permeation = await Geolocator.requestPermission();
    }
    log(permeation.toString());
  }

  Future<void> getLatAndLong() async {
    cl = await Geolocator.getCurrentPosition().then((value) => value);
    widget.lat = cl!.latitude;
    widget.lon = cl!.longitude;
    location['lat'] = widget.lat;
    location['long'] = widget.lon;
    _markers.add(Marker(
      markerId: const MarkerId('1'),
      position: LatLng(cl!.latitude, cl!.longitude),
    ));

    _kGooglePlex = CameraPosition(
      target: LatLng(widget.lat, widget.lon),
      zoom: 16.4746,
    );
    setState(() {});
  }

  @override
  void initState() {
    if (widget.lat == null && widget.lon == null && widget.locations.isEmpty) {
      getPosition();
      getLatAndLong();
    }

    if (widget.locations.isNotEmpty) {
      //_markers.clear();
      x();
    }
    super.initState();
  }

  Map<String, dynamic> location = {};
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  void x() {
    _markers.clear();
    for (var element in widget.locations) {
      _markers.add(Marker(
        markerId: MarkerId(element.id.toString()),
        position: LatLng(element.x, element.y),
      ));
    }
    _kGooglePlex = CameraPosition(
      target: LatLng(widget.locations[0].x, widget.locations[0].y),
      zoom: 16.4746,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.lat != null && widget.lon != null) {
      _markers.clear();
      _markers = {
        Marker(
          markerId: const MarkerId('1'),
          position: LatLng(widget.lat, widget.lon),
        ),
      };
      _kGooglePlex = CameraPosition(
        target: LatLng(widget.lat, widget.lon),
        zoom: 16.4746,
      );
      // setState(() {});
    }

    // setState(() {});

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          _kGooglePlex == null || _markers.isEmpty
              ? const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Expanded(
                  child: GoogleMap(
                    onTap: (val) {
                      if (widget.select == true) {
                        widget.lat = val.latitude;
                        location['lat'] = widget.lat;

                        widget.lon = val.longitude;
                        location['long'] = widget.lon;

                        setState(() {
                          _markers.clear();
                          _markers.add(Marker(
                              markerId: const MarkerId('1'),
                              position: LatLng(widget.lat!, widget.lon!),
                              onTap: () {},
                              draggable: true));
                        });
                      }
                      // }
                    },
                    mapType: MapType.normal,
                    markers: _markers,
                    initialCameraPosition: _kGooglePlex as CameraPosition,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                ),
          // if (widget.select == true)
          Container(
            padding: const EdgeInsets.all(6),
            width: double.infinity,
            child: ElevatedButton(
              //  style: ButtonStyle(alignment: Alignment.),
              child: const Text(
                'Save Location',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onPressed: () async {
                Navigator.pop(context, location);
              },
            ),
          ),
        ],
      ),
    );
  }
}
