import 'package:flutter/material.dart';
import 'package:mobigic_test/core/fonts/font.dart';

class TextFormWidget extends StatelessWidget {
  TextFormWidget(
      {super.key,
      this.textEditingController,
      this.labelText,
      this.labelStyle,
      required this.keyboardType,
      required this.cursorColor,
      this.onChanged,
      this.validator,
      required this.textAlign,
      this.maxLength,
      this.prefixIcon});

  String? labelText;
  TextEditingController? textEditingController;
  final TextInputType keyboardType;
  TextStyle? labelStyle;
  final Color cursorColor;
  Function(String)? onChanged;
  String? Function(String?)? validator;
  TextAlign textAlign;
  int? maxLength;
  Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      textAlign: textAlign,
      validator: validator,
      onChanged: onChanged,
      style: textFieldStyle,
      cursorColor: cursorColor,
      controller: textEditingController,
      keyboardType: keyboardType,
      cursorHeight: 22,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        labelText: labelText,
        labelStyle: labelTextStyle,
        contentPadding: const EdgeInsets.all(18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
        ),
      ),
    );
  }
}
