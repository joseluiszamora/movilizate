import 'package:flutter/material.dart';

class RippleUserMarker extends StatefulWidget {
  final Color color;
  final double size;

  const RippleUserMarker({
    super.key,
    this.color = Colors.blue,
    this.size = 50.0,
  });

  @override
  State<RippleUserMarker> createState() => _RippleUserMarkerState();
}

class _RippleUserMarkerState extends State<RippleUserMarker>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ...List.generate(3, (index) {
          return AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final animationValue = (_controller.value - (index / 3)) % 1.0;
              final scale = 1.0 + animationValue;
              final opacity = 1.0 - animationValue;

              return Transform.scale(
                scale: scale,
                child: Opacity(
                  opacity: opacity,
                  child: Container(
                    width: widget.size,
                    height: widget.size,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.color.withValues(alpha: 0.1),
                    ),
                  ),
                ),
              );
            },
          );
        }),
        Container(
          width: widget.size * 0.6,
          height: widget.size * 0.6,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.color,
            border: Border.all(color: Colors.white, width: 2.0),
          ),
          child: Icon(
            Icons.person,
            color: Colors.white,
            size: widget.size * 0.3,
          ),
        ),
      ],
    );
  }
}
