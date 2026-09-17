import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

typedef OnChanged = void Function(String);
typedef OnValidator = String? Function(String?);

class CustomTextField extends StatelessWidget {
  final Color? borderColor;
  final Color? curserColor;
  final String? hintText;
  final String? labelText;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextStyle? style;
  final TextEditingController? controller;
  final OnChanged? onChanged;
  final OnValidator? validator;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final int? maxLines;

  final String? obscuringCharacter;

  const CustomTextField({
    super.key,
    this.borderColor,
    this.curserColor,
    this.hintText,
    this.labelText,
    this.hintStyle,
    this.labelStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.style,
    this.controller,
    this.onChanged,
    this.validator,
    this.keyboardType,
    this.obscureText,
    this.maxLines,
    this.obscuringCharacter,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      keyboardType: keyboardType ?? TextInputType.text,
      obscureText: obscureText ?? false,
      obscuringCharacter: obscuringCharacter ?? '*',
      maxLines: maxLines ?? 1,
      cursorColor: curserColor ?? AppColors.mainColorLight,
      style: style,
      decoration: InputDecoration(
        enabledBorder: _buildDecorationBorder(
          borderColor: borderColor ?? Theme.of(context).highlightColor,
        ),
        focusedBorder: _buildDecorationBorder(
          borderColor: borderColor ?? Theme.of(context).highlightColor,
        ),
        errorBorder: _buildDecorationBorder(borderColor: AppColors.red),
        focusedErrorBorder: _buildDecorationBorder(borderColor: AppColors.red),
        hintText: hintText,
        hintStyle: hintStyle,
        labelText: labelText,
        labelStyle: labelStyle,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }

  OutlineInputBorder _buildDecorationBorder({required Color borderColor}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(width: 2, color: borderColor),
    );
  }
}
