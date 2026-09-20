import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/ui/home/tabs/favourite/favourite_tab.dart';
import 'package:evently/ui/home/tabs/home/home_tab.dart';
import 'package:evently/ui/home/tabs/profile/profile_tab.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Widget> tabsList = [HomeTab(), FavouriteTab(), ProfileTab()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          selectedIndex = index;
          setState(() {

          });
        },
        currentIndex: selectedIndex,
        items: [
          _buildBottomNavBarItem(
              isSelected: selectedIndex == 0,
              unSelectedIconName: Icons.home_outlined,
              selectedIconName: Icons.home_rounded,
              label: AppLocalizations.of(context)!.home),
          _buildBottomNavBarItem(
              isSelected: selectedIndex == 1,
              unSelectedIconName: Icons.favorite_outline_outlined,
              selectedIconName: Icons.favorite,
              label: AppLocalizations.of(context)!.favorite),
          _buildBottomNavBarItem(
              isSelected: selectedIndex == 2,
              unSelectedIconName: Icons.person_2_outlined,
              selectedIconName: Icons.person,
              label: AppLocalizations.of(context)!.profile),
        ],
      ),
      body: tabsList[selectedIndex],
      floatingActionButton: FloatingActionButton
        (onPressed: () {
        Navigator.of(context).pushNamed(AppRoutes.addEventRouteName);
      },
        child: Icon(Icons.add, color: AppColors.white, size: 25,),
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavBarItem({
    required String label,
    required IconData selectedIconName,
    required IconData unSelectedIconName,
    required isSelected
  }) {
    return BottomNavigationBarItem(
        icon: Icon(isSelected ? selectedIconName : unSelectedIconName)
        , label: label);
  }
}