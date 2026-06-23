import 'package:flutter/material.dart';

/// Wraps any widget with a decorative slider.png pinned at the bottom.
/// Used on all dark-background screens to match the home screen style.
class SkybaSliderBody extends StatelessWidget {
  final Widget child;

  const SkybaSliderBody({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: IgnorePointer(
            child: Image.asset(
              'assets/images/Slider.png',
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ],
    );
  }
}
