import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/utils/size_utils.dart';
import 'package:flutter/material.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var width = context.width;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: height * 0.04,
      ),
      child: Column(
        children: [
          Text(AppLocalizations.of(context)!.english),
          Text(AppLocalizations.of(context)!.arabic),
        ],
      ),
    );
  }
}
