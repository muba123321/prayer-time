import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int? maxlines;
  final TextStyle? hintstyle;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final InputBorder? border;
  final InputBorder? focusborder;
  final InputBorder? enableborder;
  final InputBorder? disableborder;
  final TextInputType keyboardType;
  final bool obscureText;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.suffixIcon,
    this.border,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.focusborder,
    this.enableborder,
    this.disableborder,
    this.maxlines,
    this.hintstyle,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
        hintStyle: GoogleFonts.aBeeZee(
            fontSize: 16,
            fontWeight: FontWeight.w900,
            color: Colors.black.withOpacity(0.3)),
        hintText: hintText,
        suffixIcon: suffixIcon,
        border: border ??
            const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))),
        focusedBorder: focusborder ??
            const OutlineInputBorder(
                borderSide: BorderSide(
                    width: 2, style: BorderStyle.solid, color: Colors.black),
                borderRadius: BorderRadius.all(Radius.circular(12))),
        enabledBorder: enableborder ??
            OutlineInputBorder(
                borderSide: BorderSide(
                    width: 2,
                    style: BorderStyle.solid,
                    color: Colors.black.withOpacity(0.3)),
                borderRadius: const BorderRadius.all(Radius.circular(12))),
        disabledBorder: enableborder ??
            const OutlineInputBorder(
                borderSide: BorderSide(
                    width: 2, style: BorderStyle.solid, color: Colors.black),
                borderRadius: BorderRadius.all(Radius.circular(12))),
      ),
      maxLines: maxlines,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
    );
  }
}
