import 'package:flutter/material.dart';

class EditField extends StatelessWidget {
  const EditField({
    Key? key,
    required TextEditingController controller,
    required String labelText,
    bool obscureText = false,
  })  : _controller = controller,
        _labelText = labelText,
        _obscureText = obscureText,
        super(key: key);

  final TextEditingController _controller;
  final String _labelText;
  final bool _obscureText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        style: TextStyle(color: Colors.white),
        obscureText: _obscureText,
        controller: _controller,
        decoration: InputDecoration(
          labelText: _labelText,
          labelStyle: TextStyle(color: Colors.red),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 2.0),
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
      ),
    );
  }
}
