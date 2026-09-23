import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/ui/home/tabs/profile/language/language_bottom_sheet.dart';
import 'package:evently/ui/home/tabs/profile/theme/theme_bottom_sheet.dart';
import 'package:evently/ui/home/tabs/profile/widgets/app_config_item.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/app_language_provider.dart';
import '../../../../providers/app_theme_provider.dart';
import '../../../../utils/size_utils.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    var height = context.height;
    var width = context.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width*0.04, vertical: height*0.04),
      child: SafeArea(
        child: Column(
            spacing: height*0.02,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(AppAssets.routeLogo),
              ),
              Text(userProvider.currentUser!.name,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              Text(userProvider.currentUser!.email,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(height: height*0.01,),
              AppConfigItem(text: AppLocalizations.of(context)!.darkMode,
                icon: Switch(
                  activeTrackColor: Theme.of(context).cardColor,
                    inactiveTrackColor: Theme.of(context).focusColor,
                    trackOutlineColor: WidgetStateColor.transparent,
                    value: themeProvider.isDarkMode(context),
                    onChanged: (value){
                      themeProvider.changeTheme(value ? ThemeMode.dark : ThemeMode.light);
                    }
                ),
              ),
              AppConfigItem(text: AppLocalizations.of(context)!.language,
                icon: IconButton(onPressed: (){
                  showLanguageBottomSheet();
                }, icon: Icon(Icons.arrow_forward_ios,color: Theme.of(context).cardColor,),),
              ),
              AppConfigItem(text: AppLocalizations.of(context)!.logout,
                icon: IconButton(icon: Icon(Icons.logout , color: AppColors.red),
                  onPressed: (){
                    // delete account =>  FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRoutes.loginRouteName,
                          (route) => false,
                    );
                  },),
              )
            ]
        ),
      ),
    );
  }


  void showLanguageBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => LanguageBottomSheet(),
    );
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => ThemeBottomSheet(),
    );
  }
}
