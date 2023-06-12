import 'package:flutter/material.dart';
import 'package:mobigic_test/core/fonts/font.dart';

class TextFormWidget extends StatelessWidget {
  TextFormWidget(
      {super.key,
      required this.textEditingController,
      required this.labelText,
      required this.keyboardType,
      required this.labelStyle,
      required this.cursorColor,
      this.onChanged,
      this.validator});

  final String labelText;
  final TextEditingController textEditingController;
  final TextInputType keyboardType;
  final TextStyle labelStyle;
  final Color cursorColor;
  Function(String)? onChanged;
  String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onChanged: onChanged,
      style: textFieldStyle,
      cursorColor: cursorColor,
      controller: textEditingController,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: labelTextStyle,
        contentPadding: const EdgeInsets.all(18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
