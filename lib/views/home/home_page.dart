import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Mapa como fondo principal
          // GoogleMap(
          //   onMapCreated: _onMapCreated,
          //   initialCameraPosition: CameraPosition(target: _center, zoom: 11.0),
          //   myLocationEnabled: true,
          //   myLocationButtonEnabled: false,
          //   trafficEnabled: true,
          // ),
          SizedBox(height: 200, child: Placeholder()),

          // Barra superior de búsqueda
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 10,
            right: 10,
            child: _buildSearchBar(),
          ),

          // Selector de categorías
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.15,
            left: 0,
            right: 0,
            child: _buildCategorySelector(),
          ),

          // Barra inferior con acciones rápidas
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBottomActionBar(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Icon(Icons.search, color: Colors.grey),
            SizedBox(width: 8),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Buscar dirección o lugar...',
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.mic),
              onPressed: () {
                // Acción para búsqueda por voz
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySelector() {
    return Container(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 10),
        children: [
          _buildCategoryItem(Icons.gas_meter, 'Gasolineras', Colors.blue),
          _buildCategoryItem(Icons.local_parking, 'Parqueos', Colors.green),
          _buildCategoryItem(Icons.warning, 'Conflictos', Colors.red),
          _buildCategoryItem(Icons.restaurant, 'Restaurantes', Colors.orange),
          _buildCategoryItem(Icons.hotel, 'Hoteles', Colors.purple),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(IconData icon, String label, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color.withOpacity(0.2),
            child: Icon(icon, color: color, size: 30),
          ),
          SizedBox(height: 5),
          Text(label, style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildBottomActionBar() {
    return Container(
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: () {
              // Centrar mapa en ubicación actual
            },
          ),
          IconButton(
            icon: Icon(Icons.report),
            onPressed: () {
              // Reportar incidente
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Ir a configuración
            },
          ),
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              // Abrir menú lateral
            },
          ),
        ],
      ),
    );
  }
}
