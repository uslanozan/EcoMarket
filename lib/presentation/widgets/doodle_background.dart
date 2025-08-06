import 'package:flutter/material.dart';

class DoodleBackground extends StatelessWidget {
  final Widget child;

  const DoodleBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final doodles = <Widget>[
      _doodle("earth.png", top: 40, left: 200, size: 36),
      _doodle("leaf.png", top: 60, left: 40, size: 40),
      _doodle("trolley-cart.png", top: 120, right: 60, size: 35),
      _doodle("dollar.png", bottom: 80, left: 80, size: 30),
      _doodle("turkish-lira.png", bottom: 40, right: 80, size: 30),
      _doodle("earth.png", bottom: 140, right: 100, size: 30),
      _doodle("recycle.png", top: 100, left: 140, size: 30),
      _doodle("leaf.png", top: 220, right: 100, size: 28),
      _doodle("recycle.png", bottom: 180, left: 120, size: 25),
      _doodle("earth.png", top: 200, left: 160, size: 26),
      _doodle("trolley-cart.png", bottom: 200, right: 120, size: 34),
      _doodle("dollar.png", top: 300, right: 100, size: 24),
      _doodle("turkish-lira.png", top: 300, left: 120, size: 26),
      _doodle("recycle.png", top: 250, left: 60, size: 22),
      _doodle("leaf.png", bottom: 120, right: 140, size: 26),
      _doodle("trolley-cart.png", top: 180, right: 150, size: 25),
    ];

    return Stack(
      children: [
        ...doodles,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
          child: child,
        ),
      ],
    );
  }

  Widget _doodle(String asset,
      {double? top,
        double? left,
        double? right,
        double? bottom,
        double size = 30,
        double opacity = 0.5,
      }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Opacity(
        opacity: opacity,
        child: Image.asset(
          "assets/icons/$asset",
          width: size,
        ),
      ),
    );
  }
}
