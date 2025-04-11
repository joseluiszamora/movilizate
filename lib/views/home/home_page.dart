import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
          _buildSearchBar(),

          SizedBox(height: 20),

          _buildCategorySelector(),
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
}
