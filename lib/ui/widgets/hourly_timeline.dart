import 'package:flutter/material.dart';
import 'blood_pressure_y_axis.dart';
import 'chart_grid_lines.dart';

class TimeLinePainter extends CustomPainter {
  final int numbOfTicks;
  final double tickInterval;

  TimeLinePainter({required this.numbOfTicks, required this.tickInterval});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black54.withOpacity(0.6)
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    const double tickHeight = 8.0;
    for (int i = 0; i < numbOfTicks; i++) {
      final double x = i * tickInterval + (tickInterval / 2);
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, tickHeight),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class HourlyTimeline extends StatefulWidget {
  const HourlyTimeline({super.key});

  @override
  State<HourlyTimeline> createState() => _HourlyTimelineState();
}

class _HourlyTimelineState extends State<HourlyTimeline> {
  late ScrollController _scrollController;
  final double hourSlotWidth = 60.0;
  final int totalHours = 24;
  final double chartHeight = 120.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(mounted) {
        _scrollToCurrentHour();
      }
    });
  }

  void _scrollToCurrentHour() {
    final screenWidth = MediaQuery.of(context).size.width;
    final int currentHour = DateTime.now().hour;
    double targetOffset = (currentHour * hourSlotWidth) - (screenWidth / 2) + (hourSlotWidth / 2);
    final double maxScrollExtent = _scrollController.position.maxScrollExtent;
    targetOffset = targetOffset.clamp(0.0, maxScrollExtent);
    _scrollController.jumpTo(targetOffset);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> timeLabels = List.generate(totalHours, (index) {
      final String hour = index.toString() .padLeft(2, '0');
      return SizedBox(
        width: hourSlotWidth,
        child: Center(
          child: Text(
            '$hour:00',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              fontFamily: 'Nunito',
            ),
          ),
        ),
      );
    });

    return SizedBox(
      height: chartHeight + 40,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: chartHeight,
            child: BloodPressureYAxis(height: chartHeight),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: chartHeight,
                    width: totalHours * hourSlotWidth,
                    child: Stack(
                      children: [
                        const ChartGridLines(),
                        const Center(
                          child: Text(
                            'Grafik Estimasi Tekanan Darah',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: totalHours * hourSlotWidth,
                    height: 40,
                    child: Stack(
                      children: [
                        CustomPaint(
                          size: Size(totalHours * hourSlotWidth, 20),
                          painter: TimeLinePainter(
                            numbOfTicks: totalHours,
                            tickInterval: hourSlotWidth,
                          ),
                        ),
                        Positioned(
                          top: 15,
                          left: 0,
                          right: 0,
                          child: Row(children: timeLabels),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}