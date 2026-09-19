import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/app_language_provider.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:evently/ui/home/tabs/widgets/tab_item.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/event_item.dart';

class HomeTab extends StatefulWidget {
  HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var width = context.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    List<String> eventNamesList = [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.bookClub,
      AppLocalizations.of(context)!.exhibition,
    ];
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: height * 0.02, horizontal: width * 0.04),
        child: DefaultTabController(
          length: eventNamesList.length,
          child: Column(
            children: [
              Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: height * 0.01,
                      children: [
                        Text(AppLocalizations.of(context)!.welcomeBack,
                          style: Theme
                              .of(context)
                              .textTheme
                              .titleSmall,),
                        Text('Walid kamal', style: Theme
                            .of(context)
                            .textTheme
                            .headlineSmall,)
                      ],
                    ),
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          themeProvider.appTheme.isDark ? themeProvider
                              .changeTheme(ThemeMode.light) : themeProvider
                              .changeTheme(ThemeMode.dark);
                        },
                        icon: Icon(themeProvider.isDarkMode()
                            ? Icons.dark_mode_outlined
                            : Icons.light_mode_outlined, size: 25, color: Theme
                            .of(context)
                            .cardColor,)
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.02, vertical: height * 0.006),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Theme
                            .of(context)
                            .cardColor,
                      ),
                      child: InkWell(
                          onTap: () {
                            languageProvider.appLanguage == 'en'
                                ? languageProvider.changeLanguage('ar')
                                : languageProvider.changeLanguage('en');
                          },
                          child: Text(
                            languageProvider.appLanguage.toUpperCase(),
                            style: Theme
                                .of(context)
                                .textTheme
                                .labelSmall,)),
                    )
                  ]
              ),
              SizedBox(height: height * 0.02,),
              TabBar(
                  isScrollable: true,
                  onTap: (index) {
                    selectedIndex = index;
                    setState(() {

                    });
                  },
                  dividerColor: AppColors.transparent,
                  indicatorColor: AppColors.transparent,
                  labelPadding: EdgeInsets.symmetric(horizontal: width * 0.02),
                  tabAlignment: TabAlignment.start,
                  tabs: eventNamesList.map((eventName) {
                    return TabItem(
                      isSelected: selectedIndex ==
                          eventNamesList.indexOf(eventName),
                      eventName: eventName,
                    );
                  }).toList()),
              SizedBox(height: height * 0.02,),
              Expanded(child: ListView.separated
                (itemBuilder: (context, text) {
                return EventItem();
              },
                  separatorBuilder: (context, text) {
                    return SizedBox(height: height * 0.02);
                  },
                  itemCount: 20)
              ),
            ],
          ),
        ),
      ),
    );
  }
}
