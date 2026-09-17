import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import '../../../providers/app_theme_provider.dart';
import '../../../utils/app_routes.dart';
import '../../../utils/app_styles.dart';
import '../../../utils/size_utils.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_field.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var width = context.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.04,
            vertical: height * 0.02,
          ),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: height * 0.02,
              children: [
                Image.asset(
                  themeProvider.isDarkMode()
                      ? AppAssets.eventlyDarkS
                      : AppAssets.eventlyLightS,
                ),
                Text(
                  AppLocalizations.of(context)!.createYourAccount,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                CustomTextField(
                  hintText: AppLocalizations.of(context)!.enterYourName,
                  hintStyle: Theme.of(context).textTheme.titleSmall,
                  prefixIcon: Icon(
                    Icons.person_2_outlined,
                    color: AppColors.disable,
                  ),
                ),
                CustomTextField(
                  hintText: AppLocalizations.of(context)!.enterYourEmail,
                  hintStyle: Theme.of(context).textTheme.titleSmall,
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: AppColors.disable,
                  ),
                ),
                CustomTextField(
                  style: Theme.of(context).textTheme.bodyLarge,
                  hintText: AppLocalizations.of(context)!.enterYourPassword,
                  hintStyle: Theme.of(context).textTheme.titleSmall,
                  prefixIcon: Icon(
                    Icons.lock_open_outlined,
                    color: AppColors.disable,
                  ),
                  suffixIcon: Icon(
                    Icons.visibility_off_outlined,
                    color: AppColors.disable,
                  ),
                ),
                CustomTextField(
                  style: Theme.of(context).textTheme.bodyLarge,
                  hintText: AppLocalizations.of(context)!.confirmYourPassword,
                  hintStyle: Theme.of(context).textTheme.titleSmall,
                  prefixIcon: Icon(
                    Icons.lock_open_outlined,
                    color: AppColors.disable,
                  ),
                  suffixIcon: Icon(
                    Icons.visibility_off_outlined,
                    color: AppColors.disable,
                  ),
                ),
                SizedBox(height: height * 0.001),
                CustomElevatedButton(
                  onPressed: register,
                  child: Text(
                    AppLocalizations.of(context)!.signUp2,
                    style: AppStyles.medium20White,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.alreadyHaveAnAccount,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    TextButton(
                      onPressed: () {
                        //todo : nav to register screen.
                        Navigator.of(context)
                            .pushNamed(AppRoutes.loginRouteName);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.login,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Theme.of(context).dividerColor,
                        thickness: 2,
                        indent: width * 0.03,
                        endIndent: width * 0.03,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.or,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Expanded(
                      child: Divider(
                        color: Theme.of(context).dividerColor,
                        thickness: 2,
                        indent: width * 0.03,
                        endIndent: width * 0.03,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.001),
                CustomElevatedButton(
                  borderColor: Theme.of(context).dividerColor,
                  padding: height * 0.02,
                  onPressed: register,
                  backgroundColor: Theme.of(context).highlightColor,
                  child: Row(
                    spacing: width * 0.02,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(AppAssets.google),
                      Text(
                        AppLocalizations.of(context)!.signUpWithGoogle,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void register() {
    {
      //todo : nav to home screen.
    }
  }
}
