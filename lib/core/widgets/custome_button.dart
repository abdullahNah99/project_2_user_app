import 'package:flutter/material.dart';
import 'package:google_maps_app/core/utils/app_colors.dart';

class CustomeButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  const CustomeButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.borderRadius,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width * .9,
      height: 50,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * .1,
      ),
      child: MaterialButton(
        onPressed: onPressed,
        color: AppColors.defaultColor,
        shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(26)),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
