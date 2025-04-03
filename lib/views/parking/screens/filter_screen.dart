import 'package:flutter/material.dart';
import 'package:movilizate/core/models/filter_options.dart';

class FilterScreen extends StatefulWidget {
  final FilterOptions initialFilters;

  const FilterScreen({super.key, required this.initialFilters});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  late double _maxPrice;
  late int _minAvailableSpots;
  late double _maxDistance;
  late List<String> _selectedServices;
  late double _minRating;

  // Lista predefinida de servicios disponibles
  final List<String> _availableServices = [
    'Seguridad',
    '24 Horas',
    'Lavado',
    'Cafetería',
    'Baños',
    'Pago con tarjeta',
    'Pago móvil',
    'Iluminación',
    'Cámaras',
  ];

  @override
  void initState() {
    super.initState();
    // Inicializar con los valores pasados
    _maxPrice = widget.initialFilters.maxPrice;
    _minAvailableSpots = widget.initialFilters.minAvailableSpots;
    _maxDistance = widget.initialFilters.maxDistance;
    _selectedServices = List.from(widget.initialFilters.services);
    _minRating = widget.initialFilters.minRating;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filtrar parqueos'),
        actions: [
          TextButton(
            onPressed: () {
              // Restablecer filtros a valores predeterminados
              setState(() {
                _maxPrice = 10.0;
                _minAvailableSpots = 0;
                _maxDistance = 1.0;
                _selectedServices = [];
                _minRating = 0.0;
              });
            },
            child: const Text('Restablecer'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Precio por hora',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text('Bs. 0'),
              Expanded(
                child: Slider(
                  value: _maxPrice,
                  min: 0,
                  max: 20,
                  divisions: 20,
                  label: 'Bs. ${_maxPrice.toStringAsFixed(1)}',
                  onChanged: (value) {
                    setState(() {
                      _maxPrice = value;
                    });
                  },
                ),
              ),
              const Text('Bs. 20'),
            ],
          ),
          Text(
            'Hasta Bs. ${_maxPrice.toStringAsFixed(1)} por hora',
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 24),
          const Text(
            'Espacios disponibles',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text('0'),
              Expanded(
                child: Slider(
                  value: _minAvailableSpots.toDouble(),
                  min: 0,
                  max: 10,
                  divisions: 10,
                  label: '$_minAvailableSpots',
                  onChanged: (value) {
                    setState(() {
                      _minAvailableSpots = value.toInt();
                    });
                  },
                ),
              ),
              const Text('10+'),
            ],
          ),
          Text(
            'Mínimo $_minAvailableSpots espacios',
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 24),
          const Text(
            'Distancia máxima',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text('0.5 km'),
              Expanded(
                child: Slider(
                  value: _maxDistance,
                  min: 0.5,
                  max: 5.0,
                  divisions: 9,
                  label: '${_maxDistance.toStringAsFixed(1)} km',
                  onChanged: (value) {
                    setState(() {
                      _maxDistance = value;
                    });
                  },
                ),
              ),
              const Text('5 km'),
            ],
          ),
          Text(
            'Hasta ${_maxDistance.toStringAsFixed(1)} km',
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 24),
          const Text(
            'Calificación mínima',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text('1'),
              Expanded(
                child: Slider(
                  value: _minRating,
                  min: 0,
                  max: 5,
                  divisions: 10,
                  label: _minRating.toStringAsFixed(1),
                  onChanged: (value) {
                    setState(() {
                      _minRating = value;
                    });
                  },
                ),
              ),
              const Text('5'),
            ],
          ),
          Row(
            children: List.generate(
              5,
              (index) => Icon(
                index < _minRating.floor()
                    ? Icons.star
                    : index < _minRating
                    ? Icons.star_half
                    : Icons.star_border,
                color: Colors.amber,
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Servicios',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                _availableServices.map((service) {
                  final isSelected = _selectedServices.contains(service);
                  return FilterChip(
                    label: Text(service),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _selectedServices.add(service);
                        } else {
                          _selectedServices.remove(service);
                        }
                      });
                    },
                    selectedColor: Colors.blue.shade100,
                    checkmarkColor: Colors.blue,
                  );
                }).toList(),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(
                context,
                FilterOptions(
                  maxPrice: _maxPrice,
                  minAvailableSpots: _minAvailableSpots,
                  maxDistance: _maxDistance,
                  services: _selectedServices,
                  minRating: _minRating,
                ),
              );
            },
            child: const Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: const Text('Aplicar filtros'),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
