import 'package:flutter/material.dart';
import 'package:google_maps_app/core/utils/app_colors.dart';

class CustomeProgressIndicator extends StatelessWidget {
  final double? strokeWidth;
  const CustomeProgressIndicator({super.key, this.strokeWidth});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: AppColors.defaultColor,
        strokeWidth: strokeWidth ?? 4.0,
      ),
    );
  }
}
