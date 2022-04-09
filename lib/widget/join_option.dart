import 'package:flutter/material.dart';

class JoinOptionScreen extends StatelessWidget {
  final String text;
  final bool isMuted;
  final Function(bool) onChanged;
  const JoinOptionScreen({
    Key? key,
    required this.text,
    required this.isMuted,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                style: const TextStyle(fontSize: 18),
              ),
            ),
            Switch(
              value: isMuted,
              onChanged: onChanged,
            ),
          ],
        ),
      ],
    );
  }
}
