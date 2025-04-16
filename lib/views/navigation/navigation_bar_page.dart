import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:movilizate/core/constants/app_colors.dart';
import 'package:movilizate/core/constants/app_defaults.dart';
import 'package:movilizate/core/layouts/layout_main.dart';
import 'package:movilizate/views/fuel/fuel_page.dart';
import 'package:movilizate/views/home/home_page.dart';
import 'package:movilizate/views/parking/parking_page.dart';
import 'package:movilizate/views/poi/poi_page.dart';
import 'package:movilizate/views/profile/profile_page.dart';
import 'package:movilizate/views/teleferico_map/teleferico_map_page.dart';

class NavigationBarPage extends StatefulWidget {
  const NavigationBarPage({super.key});

  @override
  State<NavigationBarPage> createState() => _NavigationBarPageState();
}

class _NavigationBarPageState extends State<NavigationBarPage> {
  int _pageSelected = 3;

  @override
  Widget build(BuildContext context) {
    //* Pages List
    List<Widget> pages = [
      const HomePage(),
      const FuelPage(),
      const ParkingPage(),
      const TelefericoMapPage(),
      // const PoiPage(),
    ];

    return MaterialApp(
      home: Scaffold(
        // appBar: AppBar(title: const Text('Movilizate')),
        appBar: AppBar(
          title: Text('Movilizate'),
          leading: Builder(
            builder:
                (context) => IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
          ),
          actions: [
            IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
          ],
        ),
        drawer: _buildDrawer(context),

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
                  GButton(icon: LineIcons.info, text: 'POIs'),
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

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildDrawerHeader(),
          _buildDrawerItem(
            icon: Icons.person,
            text: 'Perfil',
            onTap: () => _navigateTo(context, '/profile'),
          ),
          _buildDrawerItem(
            icon: Icons.history,
            text: 'Historial',
            onTap: () => _navigateTo(context, '/history'),
          ),
          _buildDrawerItem(
            icon: Icons.settings,
            text: 'Configuración',
            onTap: () => _navigateTo(context, '/settings'),
          ),
          Divider(),
          _buildDrawerItem(
            icon: Icons.help,
            text: 'Ayuda',
            onTap: () => _navigateTo(context, '/help'),
          ),
          _buildDrawerItem(
            icon: Icons.exit_to_app,
            text: 'Cerrar sesión',
            onTap: () => _logout(context),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return DrawerHeader(
      decoration: BoxDecoration(color: Colors.blue),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage('https://example.com/profile.jpg'),
          ),
          SizedBox(height: 10),
          Text(
            'Nombre del Usuario',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'usuario@example.com',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return ListTile(leading: Icon(icon), title: Text(text), onTap: onTap);
  }

  void _navigateTo(BuildContext context, String route) {
    Navigator.pop(context); // Cierra el drawer
    Navigator.pushNamed(context, route);
  }

  void _logout(BuildContext context) {
    Navigator.pop(context); // Cierra el drawer
    // Lógica para cerrar sesión
  }
}
