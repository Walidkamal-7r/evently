import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/ui/home/tabs/profile/profile_tab.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(AppLocalizations.of(context)!.language),
      ),
      body: ProfileTab(),
    );
  }
}
