import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:evently/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/app_theme_provider.dart';

class ThemeBottomSheet extends StatefulWidget {
  const ThemeBottomSheet({super.key});

  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var width = context.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);
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
              themeProvider.changeTheme(ThemeMode.dark);
            },
            child: themeProvider.isDarkMode(context) ?
            _getSelectedItemTheme(theme: AppLocalizations.of(context)!.darkMode)
                : _getUnSelectedItemTheme(theme:AppLocalizations.of(context)!.darkMode),
          ),
          InkWell(
            onTap: () {
              themeProvider.changeTheme(ThemeMode.light);
            },
            child: !themeProvider.isDarkMode(context) ?
            _getSelectedItemTheme(theme:AppLocalizations.of(context)!.lightMode)
                : _getUnSelectedItemTheme(theme: AppLocalizations.of(context)!.lightMode),
          ),
        ],
      ),
    );
  }

  Widget _getSelectedItemTheme({required String theme}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(theme, style: AppStyles.medium14Black,),
        Icon(Icons.check, color: AppColors.mainColorLight, size: 30,),
      ],
    );
  }

  Widget _getUnSelectedItemTheme({required String theme}) {
    return Text(theme, style: AppStyles.medium14Black,);
  }
}