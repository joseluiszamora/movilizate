import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget implements PreferredSizeWidget {
  final String location;
  final String? avatarUrl;
  final VoidCallback openDrawer;

  const HeaderSection({
    super.key,
    required this.location,
    this.avatarUrl,
    required this.openDrawer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
      decoration: BoxDecoration(
        color: const Color(0xFF0bbfdf),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Avatar del usuario
            InkWell(
              onTap: openDrawer,
              child: CircleAvatar(
                radius: 20,
                backgroundImage:
                    avatarUrl != null ? NetworkImage(avatarUrl!) : null,
                backgroundColor: Colors.grey[300],
                child: avatarUrl == null ? const Icon(Icons.person) : null,
              ),
            ),

            const SizedBox(width: 12),

            // Información de ubicación
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tu ubicación',
                    style: TextStyle(fontSize: 12, color: Colors.white70),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        location,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Ícono de notificaciones
            const CircleAvatar(
              backgroundColor: Colors.white12,
              child: Icon(Icons.notifications_outlined, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 20); // Altura ajustable del AppBar
}
