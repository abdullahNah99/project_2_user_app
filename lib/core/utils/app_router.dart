import 'package:flutter/cupertino.dart';
import 'package:google_maps_app/screens/add_property_screen/add_property_screen.dart';
import 'package:google_maps_app/screens/login_screen/login_screen.dart';
import 'package:google_maps_app/screens/properties_screen/properties_screen.dart';
import 'package:google_maps_app/screens/register_screen/register_sreen.dart';

abstract class AppRouter {
  static final router = <String, WidgetBuilder>{
    LoginView.route: (context) => const LoginView(),
    RegisterView.route: (context) => const RegisterView(),
    AddPropertyView.route: (context) => const AddPropertyView(),
    // GoogleMapView.route: (context) => const GoogleMapView(),
    PropertiesView.route: (context) => const PropertiesView(),
  };
}
