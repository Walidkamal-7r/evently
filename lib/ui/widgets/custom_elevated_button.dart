import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/size_utils.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;

  final Color? backgroundColor;
  final Color? borderColor;
  final double? padding;

  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.backgroundColor,
    this.borderColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    var height = context.height;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            width: 2,
            color: borderColor ?? AppColors.transparent,
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: padding ?? height * 0.01),
        backgroundColor: backgroundColor ?? Theme.of(context).cardColor,
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
