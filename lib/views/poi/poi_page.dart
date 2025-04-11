import 'package:flutter/material.dart';

class PoiPage extends StatelessWidget {
  const PoiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Placeholder(),

        SizedBox(height: 20),
        Text("INfo de POI, con restaurantes, comida, hoteles, etc"),
      ],
    );
  }
}
