import 'package:flutter/material.dart';

class ChartGridLines extends StatelessWidget {
  const ChartGridLines({super.key});

  @override
  Widget build(BuildContext context) {
    const int lineCount = 5;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double chartHeight = constraints.maxHeight;
        return Stack(
          children: List.generate(lineCount, (index) {
            if (index == lineCount - 1) {
            return Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Divider(
                  color: Colors.black.withOpacity(0.1),
                  thickness: 1,
                  height: 1,
                ),
              );
            }
            final double topPosition = (index / (lineCount - 1)) * chartHeight;
            return Positioned(
              top: topPosition,
              left: 0,
              right: 0,
              child: Divider(
                color: Colors.black.withOpacity(0.1),
                thickness: 1,
                height: 1,
              ),
            );
          }),
        );
      }
    );
  }
}