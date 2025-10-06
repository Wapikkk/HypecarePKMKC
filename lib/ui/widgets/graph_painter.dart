import 'package:flutter/material.dart';
import 'package:hypecare_pkmkc/models/daily_history.dart';

class GraphPainter extends CustomPainter {
  final List<BloodPressurePoint> data;
  final double hourSlotWidth;
  final int totalHours = 24;
  final DailyHistory? selectedDataPoint;

  GraphPainter({required this.data, required this.hourSlotWidth, this.selectedDataPoint});

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final systolicPaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
      
    final diastolicPaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final systolicPath = Path();
    final diastolicPath = Path();

    double getYPos(num value) {
      return size.height - (value / 200) * size.height;
    }

    double getXPos(DateTime time) {
      final hour = time.hour;
      final minute = time.minute;
      return (hour + (minute / 60.0)) * hourSlotWidth + (hourSlotWidth / 2);
    }
    
    systolicPath.moveTo(getXPos(data.first.time), getYPos(data.first.systolic));
    diastolicPath.moveTo(getXPos(data.first.time), getYPos(data.first.diastolic));

    for (var point in data) {
      systolicPath.lineTo(getXPos(point.time), getYPos(point.systolic));
      diastolicPath.lineTo(getXPos(point.time), getYPos(point.diastolic));
    }

    canvas.drawPath(systolicPath, systolicPaint);
    canvas.drawPath(diastolicPath, diastolicPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}