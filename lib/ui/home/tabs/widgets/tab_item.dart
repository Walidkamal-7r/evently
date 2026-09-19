import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:evently/utils/size_utils.dart';
import 'package:flutter/material.dart';

class TabItem extends StatelessWidget {
  final bool isSelected;
  final String eventName;

  const TabItem({super.key, required this.isSelected, required this.eventName});

  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var width = context.width;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: height * 0.006,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: isSelected
            ? Theme.of(context).cardColor
            : Theme.of(context).highlightColor,
        border: Border.all(
          width: 2,
          color: isSelected
              ? AppColors.transparent
              : Theme.of(context).dividerColor,
        ),
      ),
      child: Text(
        eventName,
        style: isSelected
            ? AppStyles.medium16White
            : Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
