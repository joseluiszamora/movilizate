import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:movilizate/core/constants/app_colors.dart';
import 'package:movilizate/core/constants/app_defaults.dart';
import 'package:movilizate/core/layouts/layout_main.dart';
import 'package:movilizate/views/fuel/fuel_page.dart';
import 'package:movilizate/views/home/home_page.dart';
import 'package:movilizate/views/parking/parking_page.dart';
import 'package:movilizate/views/profile/profile_page.dart';

class NavigationBarPage extends StatefulWidget {
  const NavigationBarPage({super.key});

  @override
  State<NavigationBarPage> createState() => _NavigationBarPageState();
}

class _NavigationBarPageState extends State<NavigationBarPage> {
  int _pageSelected = 0;

  @override
  Widget build(BuildContext context) {
    //* Pages List
    List<Widget> pages = [
      const HomePage(),
      const FuelPage(),
      const ParkingPage(),
      const ProfilePage(),
    ];

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Movilizate')),
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 600),
          child: LayoutMain(content: pages[_pageSelected]),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppDefaults.margin),
            boxShadow: [
              BoxShadow(blurRadius: 20, color: Colors.black.withAlpha(1)),
            ],
          ),
          child: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 8,
              ),
              child: GNav(
                curve: Curves.easeIn,
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.red[100]!,
                gap: 8,
                activeColor: AppColors.primary,
                iconSize: 30,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: Duration(milliseconds: 400),
                tabBackgroundColor: Colors.grey[100]!,
                color: Colors.black,
                tabs: [
                  GButton(icon: LineIcons.home, text: 'Inicio'),
                  GButton(icon: LineIcons.oilCan, text: 'Gas'),
                  GButton(icon: LineIcons.car, text: 'Parqueos'),
                  GButton(icon: LineIcons.user, text: 'Profile'),
                ],
                selectedIndex: _pageSelected,
                onTabChange: (index) {
                  setState(() {
                    _pageSelected = index;
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
