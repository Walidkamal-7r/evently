import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.backgroundLight,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.white,
      selectedItemColor: AppColors.mainColorLight,
      unselectedItemColor: AppColors.disable,
      selectedLabelStyle: AppStyles.regular12MainLight,
      unselectedLabelStyle: AppStyles.regular12Disable,
    ),
    cardColor: AppColors.mainColorLight,
    dividerColor: AppColors.strokeLight,
    highlightColor: AppColors.inputsLight,
    focusColor: AppColors.disable,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.mainColorLight,
        shape: StadiumBorder()),
    textTheme: TextTheme(
      titleSmall: AppStyles.regular14secTextLight,
      titleMedium: AppStyles.medium20MainTextLight,
      titleLarge: AppStyles.semiBold20Black,
      bodySmall: AppStyles.regular16secTextLight,
      headlineSmall: AppStyles.medium20White,
      labelSmall: AppStyles.regular14white,
      labelMedium: AppStyles.medium20Black,
      labelLarge: AppStyles.semiBold24MainLight,
      headlineMedium: AppStyles.medium18MainLight,
      bodyLarge: AppStyles.medium16Black,
      displaySmall: AppStyles.regular14MainLight,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.backgroundDark,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.backgroundDark,
      selectedItemColor: AppColors.mainColorDark,
      unselectedItemColor: AppColors.disable,
      selectedLabelStyle: AppStyles.regular12MainDark,
      unselectedLabelStyle: AppStyles.regular12Disable,
    ),
    cardColor: AppColors.mainColorDark,
    dividerColor: AppColors.strokeDark,
    highlightColor: AppColors.inputsDark,
    focusColor: AppColors.disable,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.mainColorDark,
        shape: StadiumBorder()),
    textTheme: TextTheme(
      titleSmall: AppStyles.regular14SecondText,
      titleMedium: AppStyles.medium20MainTextDark,
      titleLarge: AppStyles.semiBold20white,
      bodySmall: AppStyles.regular16secTextDark,
      headlineSmall: AppStyles.medium20White,
      labelSmall: AppStyles.regular14white,
      labelMedium: AppStyles.medium20White,
      labelLarge: AppStyles.semiBold24MainDark,
      headlineMedium: AppStyles.medium18MainDark,
      bodyLarge: AppStyles.medium16White,
      displaySmall: AppStyles.regular14MainDark,
    ),
  );
}
