import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_app/screens/login_screen/login_screen.dart';
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
          ),
          debugShowCheckedModeBanner: false,
          home: const LoginView(),
          // initialRoute: CacheHelper.getData(key: 'Token') == null
          //     ? LoginView.route
          //     : AddPropertyView.route,
          // routes: AppRouter.router,
        );
      },
    );
  }
}
