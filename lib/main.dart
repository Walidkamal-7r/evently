import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/app_language_provider.dart';
import 'package:evently/ui/home/home_screen.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
void main(){
  runApp(ChangeNotifierProvider(
      create: (context) => AppLanguageProvider(),
      child: (MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.homeRouteName,
      routes: {
        AppRoutes.homeRouteName: (context) => const HomeScreen(),
      },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(languageProvider.appLanguage),
    );
  }
}
