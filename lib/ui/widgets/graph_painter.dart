// lib/widgets/graph_painter.dart
import 'package:flutter/material.dart';
import 'package:hypecare_pkmkc/models/daily_history.dart'; // Pastikan path benar

class GraphPainter extends CustomPainter {
  final List<BloodPressurePoint> data;
  final double hourSlotWidth;
  final int totalHours = 24;

  GraphPainter({required this.data, required this.hourSlotWidth});

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

    // Fungsi untuk mengubah nilai tekanan darah menjadi posisi Y di canvas
    double getYPos(num value) {
      // Asumsi range 0-200 mmHg
      return size.height - (value / 200) * size.height;
    }

    // Fungsi untuk mengubah waktu menjadi posisi X di canvas
    double getXPos(DateTime time) {
      final hour = time.hour;
      final minute = time.minute;
      return (hour + (minute / 60.0)) * hourSlotWidth + (hourSlotWidth / 2);
    }
    
    // Mulai path
    systolicPath.moveTo(getXPos(data.first.time), getYPos(data.first.systolic));
    diastolicPath.moveTo(getXPos(data.first.time), getYPos(data.first.diastolic));

    // Hubungkan semua titik data
    for (var point in data) {
      systolicPath.lineTo(getXPos(point.time), getYPos(point.systolic));
      diastolicPath.lineTo(getXPos(point.time), getYPos(point.diastolic));
    }

    // Gambar path ke canvas
    canvas.drawPath(systolicPath, systolicPaint);
    canvas.drawPath(diastolicPath, diastolicPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}