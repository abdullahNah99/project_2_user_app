import 'package:flutter/material.dart';
import 'package:google_maps_app/core/utils/app_colors.dart';

class CustomeIcon extends StatelessWidget {
  final IconData icon;
  final double? size;
  const CustomeIcon({super.key, required this.icon, this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size ?? 45.0,
      height: size ?? 45.0,
      decoration: const BoxDecoration(
          color: AppColors.color2,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Icon(
        icon,
        size: size == null ? 30.0 : (size! * (2 / 3)),
        color: AppColors.defaultColor,
      ),
    );
  }
}
