import 'package:flutter/material.dart';

class BloodPressureYAxis extends StatelessWidget {
  final double height;
  const BloodPressureYAxis({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    final List<String> labels = ['200', '150', '100', '50', '0'];
    const double fontSize = 11.0;

    return SizedBox(
      width: 25,
      height: height,
      child: Stack(
        clipBehavior: Clip.none,
        children: List.generate(labels.length, (index) {
          final double topPosition = (index / (labels.length - 1)) * height;
          
          return Positioned(
            top: topPosition - (fontSize / 2),
            height: fontSize,
            left: 0,
            right: 4,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                labels[index],
                style: const TextStyle(
                  fontSize: fontSize,
                  color: Colors.black54,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}