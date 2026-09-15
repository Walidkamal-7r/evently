import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:evently/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/app_language_provider.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({super.key});

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var width = context.width;
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: height * 0.04,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        spacing: height * 0.02,
        children: [
          InkWell(
            onTap: () {
              languageProvider.changeLanguage('en');
            },
            child: languageProvider.appLanguage == 'en' ? _getSelectedItemLanguage(language: 'English')
                : _getUnSelectedItemLanguage(language: 'English'),
          ),
          InkWell(
            onTap: () {
              languageProvider.changeLanguage('ar');
            },
            child: languageProvider.appLanguage == 'ar' ? _getSelectedItemLanguage(language: 'Arabic')
                : _getUnSelectedItemLanguage(language: 'Arabic'),
          ),
        ],
      ),
    );
  }

  Widget _getSelectedItemLanguage({required String language}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(language, style: AppStyles.medium14Black,),
        Icon(Icons.check, color: AppColors.mainColorLight, size: 30,),
      ],
    );
  }

  Widget _getUnSelectedItemLanguage({required String language}) {
    return Text(language, style: AppStyles.medium14Black,);
  }
}