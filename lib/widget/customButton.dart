import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomButton extends StatelessWidget {
  final double height, width;
  final String text;
  final Color color;
  final bool isLogo;
  final String icon;
  final VoidCallback onpress;
  const CustomButton({
    Key? key,
    required this.height,
    required this.width,
    required this.text,
    required this.color,
    this.isLogo = false,
    this.icon = 'assets/images/google_svg.svg',
    required this.onpress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onpress,
        style: ElevatedButton.styleFrom(
          primary: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(29.0),
          ),
        ),
        child: isLogo ? SvgPicture.asset(icon) : Text(text),
      ),
    );
  }
}
