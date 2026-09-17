import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import '../../../providers/app_theme_provider.dart';
import '../../../utils/app_styles.dart';
import '../../../utils/size_utils.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                  AppLocalizations.of(context)!.loginToYourAccount,
                  style: Theme.of(context).textTheme.labelLarge,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        //todo : nav to forget password screen.
                      },
                      child: Text(
                        AppLocalizations.of(context)!.forgetPassword,
                        style: Theme.of(context).textTheme.displayMedium
                            ?.copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor: Theme.of(context).dividerColor,
                            ),
                      ),
                    ),
                  ],
                ),
                CustomElevatedButton(
                  onPressed: login,
                  child: Text(
                    AppLocalizations.of(context)!.login,
                    style: AppStyles.medium20White,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.dontHaveAnAccount,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    TextButton(
                      onPressed: () {
                        //todo : nav to register screen.
                        Navigator.of(context)
                            .pushNamed(AppRoutes.registerRouteName);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.signUp,
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
                SizedBox(height: height * 0.01),
                CustomElevatedButton(
                  borderColor: Theme.of(context).dividerColor,
                  padding: height * 0.02,
                  onPressed: login,
                  backgroundColor: Theme.of(context).highlightColor,
                  child: Row(
                    spacing: width * 0.02,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(AppAssets.google),
                      Text(
                        AppLocalizations.of(context)!.loginWithGoogle,
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

  void login() {
    {
      //todo : nav to home screen.
    }
  }
}
