import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required TextEditingController controller,
    required this.hintText,
    required this.message,
    required this.icon,
  })  : _controller = controller,
        super(key: key);

  final TextEditingController _controller;
  final String hintText, message;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: TextFormField(
        controller: _controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(
              width: 0,
            ),
          ),
          hintText: hintText,
          prefixIcon: icon,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return message;
          }
          return null;
        },
      ),
    );
  }
}
