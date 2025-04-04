import 'package:flutter/material.dart';

class PulsatingUserMarker extends StatefulWidget {
  final Color color;
  final double size;

  const PulsatingUserMarker({
    super.key,
    this.color = Colors.blue,
    this.size = 40.0,
  });

  @override
  State<PulsatingUserMarker> createState() => _PulsatingUserMarkerState();
}

class _PulsatingUserMarkerState extends State<PulsatingUserMarker>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.color.withValues(alpha: 0.2),
              border: Border.all(
                color: widget.color.withValues(alpha: 0.8),
                width: 2.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: widget.color.withValues(alpha: 0.3),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Center(
              child: Icon(
                Icons.person_pin_circle,
                color: widget.color,
                size: widget.size * 0.6,
              ),
            ),
          ),
        );
      },
    );
  }
}
