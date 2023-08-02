// import 'package:flutter/material.dart';
// import 'package:google_maps_app/core/models/region_model.dart';

// class GoogleMapView extends StatelessWidget {
//   static const route = 'GoogleMapView';
//   const GoogleMapView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     RegionModel? region =
//         ModalRoute.of(context)!.settings.arguments as RegionModel?;
//     return Scaffold(
//       body: GoogleMapViewBody(region: region),
//     );
//   }
// }

// class GoogleMapViewBody extends StatelessWidget {
//   final RegionModel? region;
//   const GoogleMapViewBody({super.key, required this.region});

//   @override
//   Widget build(BuildContext context) {
//     return const Column();
//   }
// }

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class GoogleMapView extends StatefulWidget {
  static const route = 'GoogleMapView';
  GoogleMapView({super.key, required this.select, this.lat, this.lon});
  final bool select;
  var lat;
  var lon;

  @override
  State<GoogleMapView> createState() => _googleMapViewState();
}

class _googleMapViewState extends State<GoogleMapView> {
  Position? cl;

  CameraPosition? _kGooglePlex;
  Set<Marker>? _markers;

  Future getPosition() async {
    bool services;
    LocationPermission permeation;

    services = await Geolocator.isLocationServiceEnabled();
    print(services);
    if (services == false) {
      // do any thing if you wont;
    }

    permeation = await Geolocator.checkPermission();
    if (permeation == LocationPermission.denied) {
      permeation = await Geolocator.requestPermission();
    }
    print(permeation);
  }

  Future<void> getLatAndLong() async {
    cl = await Geolocator.getCurrentPosition().then((value) => value);
    widget.lat = cl!.latitude;
    widget.lon = cl!.longitude;
    location['lat'] = widget.lat;
    location['long'] = widget.lon;
    // _kGooglePlex = CameraPosition(
    //   target: LatLng(widget.lat, widget.lon),
    //   zoom: 16.4746,
    // );
    _markers = {
      Marker(
        markerId: const MarkerId('1'),
        position: LatLng(cl!.latitude, cl!.longitude),
      )
    };
    setState(() {});
  }

  @override
  void initState() {
    if (widget.lat == null && widget.lon == null) {
      getPosition();
      getLatAndLong();
    }
    super.initState();
  }

  Map<String, dynamic> location = {};
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    if (widget.lat != null && widget.lon != null) {
      _kGooglePlex = CameraPosition(
        target: LatLng(widget.lat, widget.lon),
        zoom: 16.4746,
      );
      _markers = {
        Marker(
          markerId: const MarkerId('1'),
          position: LatLng(widget.lat, widget.lon),
        ),
        // Marker(
        //   markerId: const MarkerId('2'),
        //   position: LatLng(widget.lat, widget.lon),
        // )
      };
      setState(() {});
    }
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          _kGooglePlex == null
              ? const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Expanded(
                  child: GoogleMap(
                    onTap: (val) {
                      // if (widget.select == true) {
                      widget.lat = val.latitude;
                      location['lat'] = widget.lat;

                      widget.lon = val.longitude;
                      location['long'] = widget.lon;
                      setState(() {
                        _markers!.clear();
                        _markers!.add(Marker(
                            markerId: const MarkerId('1'),
                            position: LatLng(widget.lat!, widget.lon!),
                            onTap: () {},
                            draggable: true));
                      });
                      // }
                    },
                    mapType: MapType.normal,
                    markers: _markers as Set<Marker>,
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
