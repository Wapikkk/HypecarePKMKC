import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'blood_pressure_y_axis.dart';
import 'chart_grid_lines.dart';
import '../../models/daily_history.dart';

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
      final double x = i * tickInterval;
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
  final List<BloodPressurePoint> data;
  const HourlyTimeline({super.key, this.data = const []});

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
    if (!mounted) return;
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
              padding: EdgeInsets.zero,
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
                        if (widget.data.isNotEmpty)
                          Container(
                            width: totalHours * hourSlotWidth,
                            height: chartHeight,
                            child: InteractiveBpChart(data: widget.data),
                          )
                        else 
                          const Center(
                            child: Text(
                              'Tidak ada data yang ditampilkan',
                              style: TextStyle(
                                color: Colors.black54
                              ),
                            ),
                          ),
                        // CustomPaint(
                        //   size: Size(totalHours * hourSlotWidth, chartHeight),
                        //   painter: GraphPainter(
                        //     data: widget.data,
                        //     hourSlotWidth: hourSlotWidth,
                        //   ),
                        // ),
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
                        Transform.translate(
                          offset: const Offset(-30, 0),
                          child: Positioned(
                            top: 15,
                            left: 0,
                            right: 0,
                            child: Row(children: timeLabels),
                          ),
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

class InteractiveBpChart extends StatefulWidget {
  final List<BloodPressurePoint> data;
  final Color systolicColor;
  final Color diastolicColor;

  const InteractiveBpChart ({
    super.key,
    required this.data,
    this.systolicColor = Colors.red,
    this.diastolicColor = Colors.blue,
  });

  @override
  State<InteractiveBpChart> createState() => _InteractiveBpChartState();
}

class _InteractiveBpChartState extends State<InteractiveBpChart> {
  List<int> showingTooltipOnSpots= [];
  late List<LineChartBarData> lineBarsData;

  @override
  void initState() {
    super.initState();
    lineBarsData = _buildLineBarsData();
  }

  List<LineChartBarData> _buildLineBarsData() {
    widget.data.sort((a, b) => a.time.compareTo(b.time));

    final systolicSpots = widget.data.map((p) {
      final double xValue = p.time.hour + (p.time.minute / 60.0);
      return FlSpot(xValue, p.systolic.toDouble());
    }).toList();

    final diastolicSpots = widget.data.map((p) {
      final double xValue = p.time.hour + (p.time.minute / 60.0);
      return FlSpot(xValue, p.diastolic.toDouble());
    }).toList();

    return [
      _buildLineChartBarData(systolicSpots, widget.systolicColor),
      _buildLineChartBarData(diastolicSpots, widget.diastolicColor),
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data.isEmpty) {
      return const SizedBox.shrink();
    }

    return LineChart(
      LineChartData(
        showingTooltipIndicators: showingTooltipOnSpots.map((index) {
          return ShowingTooltipIndicators([
            LineBarSpot(
              lineBarsData[0],
              0,
              lineBarsData[0].spots[index],
            ),
            LineBarSpot(
              lineBarsData[1],
              1,
              lineBarsData[1].spots[index],
            ),
          ]);
        }).toList(),
        
        lineTouchData: LineTouchData(
          handleBuiltInTouches: false,
          touchCallback: (FlTouchEvent event, LineTouchResponse? touchResponse) {
            if (touchResponse == null || touchResponse.lineBarSpots == null) {
              return;
            }
            if (event is FlTapUpEvent) {
               setState(() {
                final spotIndexes = touchResponse.lineBarSpots!.map((spot) => spot.spotIndex).toList();
                if (showingTooltipOnSpots.isNotEmpty && showingTooltipOnSpots.first == spotIndexes.first) {
                  showingTooltipOnSpots = [];
                } else {
                  showingTooltipOnSpots = spotIndexes;
                }
              });
            }
          },

          getTouchedSpotIndicator: (LineChartBarData barData, List<int> spotIndexes) {
            return spotIndexes.map((spotIndex) {
              return TouchedSpotIndicatorData(
                FlLine(color: Colors.transparent),
                FlDotData(
                  getDotPainter: (spot, percent, barData, index) {
                    return FlDotCirclePainter(
                      radius: 5,
                      color: barData.color ?? (barData == 0 ? widget.systolicColor : widget.diastolicColor),
                      strokeColor: Colors.white,
                      strokeWidth: 0,
                    );
                  },
                ),
              );
            }).toList();
          },

          touchTooltipData: LineTouchTooltipData(
            tooltipHorizontalAlignment: FLHorizontalAlignment.right,
            getTooltipColor: (spot) => Colors.blueGrey.withOpacity(0.8),
            tooltipMargin: -60,
            getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
              if(touchedBarSpots.isEmpty) {
                return [];
              }
              return touchedBarSpots.map((barSpot) {
                final spotX = barSpot.x;
                final pointData = widget.data.reduce((a, b) => 
                  (a.time.hour + (a.time.minute/60.0) - spotX).abs() < 
                  (b.time.hour + (b.time.minute/60.0) - spotX).abs() ? a : b
                );
                final formattedTime = DateFormat('HH:mm').format(pointData.time);

                String pressureText = '';

                if(barSpot.barIndex == 0) {
                  pressureText = 'Sistolik: ${barSpot.y.toStringAsFixed(0)} mmHg';
                } else if (barSpot.barIndex == 1){
                  pressureText = 'Diastolik: ${barSpot.y.toStringAsFixed(0)} mmHg';
                }

                return 
                LineTooltipItem(
                  '$pressureText\n',
                  const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Nunito',
                    fontSize: 10,
                  ),
                  children: [
                    TextSpan(
                      text: 'Pukul $formattedTime',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Nunito',
                        fontSize: 10,
                      ),
                    ),
                  ],
                );
              }).toList();
            }
          ),
        ),
        gridData: const FlGridData(show: false),
        titlesData: const FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        lineBarsData: lineBarsData,
        minX: 0,
        maxX: 24,
        minY: 0,
        maxY: 200,
      ),
    );
  }

  LineChartBarData _buildLineChartBarData(List<FlSpot> spots, Color color) {
    return LineChartBarData(
      spots: spots,
      isCurved: true,
      color: color,
      barWidth: 3,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: true),
      belowBarData: BarAreaData(show: false),
    );
  }
}