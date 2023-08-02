import 'package:flutter/material.dart';
import 'package:google_maps_app/core/models/region_model.dart';

class GoogleMapView extends StatelessWidget {
  static const route = 'GoogleMapView';
  const GoogleMapView({super.key});

  @override
  Widget build(BuildContext context) {
    RegionModel? region =
        ModalRoute.of(context)!.settings.arguments as RegionModel?;
    return Scaffold(
      body: GoogleMapViewBody(region: region),
    );
  }
}

class GoogleMapViewBody extends StatelessWidget {
  final RegionModel? region;
  const GoogleMapViewBody({super.key, required this.region});

  @override
  Widget build(BuildContext context) {
    return const Column();
  }
}
