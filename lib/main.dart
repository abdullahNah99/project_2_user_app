import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:google_maps_app/core/utils/app_colors.dart';
import 'package:google_maps_app/core/utils/app_router.dart';
import 'package:google_maps_app/screens/add_property_screen/add_property_screen.dart';

import 'package:google_maps_app/screens/login_screen/login_screen.dart';
import 'package:google_maps_app/screens/properties_screen/properties_screen.dart';
import 'core/api/dio_helper.dart';
import 'core/utils/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init();
  runApp(const MapsApp());
}

class MapsApp extends StatelessWidget {
  const MapsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, state) {
        return MaterialApp(
          theme: ThemeData(
            useMaterial3: true,
            primaryColor: AppColors.defaultColor,
          ),
          debugShowCheckedModeBanner: false,

          initialRoute: PropertiesView.route,
          //  CacheHelper.getData(key: 'Token') == null
          //     ? LoginView.route
          //     : AddPropertyView.route,
          routes: AppRouter.router,

        );
      },
    );
  }
}
