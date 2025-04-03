import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class ErrorUiScreen extends StatelessWidget {
  const ErrorUiScreen({
    super.key,
    required this.errorMessage,
    required this.reloadParkings,
  });
  final String errorMessage;
  final Function() reloadParkings;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.location_off, size: 50, color: Colors.red),
          const SizedBox(height: 20),
          Text(
            errorMessage,
            style: const TextStyle(fontSize: 16, color: Colors.red),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () => _handlePermissionRetry(context),
            icon: const Icon(Icons.location_on),
            label: const Text('Intentar nuevamente'),
          ),
          TextButton(
            onPressed: () => openAppSettings(),
            child: const Text('Abrir configuración'),
          ),
        ],
      ),
    );
  }

  Future<void> _handlePermissionRetry(BuildContext context) async {
    final status = await Permission.location.request();
    if (status.isGranted) {
      reloadParkings();
    }
  }
}
