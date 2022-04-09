import 'package:flutter/material.dart';

class HomeIcons extends StatelessWidget {
  final IconData buttonIcon;
  final Color buttonColor;
  final String text;
  final VoidCallback ontap;
  const HomeIcons({
    Key? key,
    required this.buttonIcon,
    required this.buttonColor,
    required this.text,
    required this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: ontap,
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  color: Colors.black.withOpacity(0.06),
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              buttonIcon,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
        Text(text),
      ],
    );
  }
}
