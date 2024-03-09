// bar_chart_screen.dart
import 'dart:math' as math;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:app_usage/app_usage.dart';

class BarChartScreen extends StatefulWidget {
  final List<AppUsageInfo> usageInfos;

  BarChartScreen({Key? key, required this.usageInfos}) : super(key: key);

  @override
  State<BarChartScreen> createState() => _BarChartScreenState();
}

class _BarChartScreenState extends State<BarChartScreen> {
  int touchedGroupIndex = -1;

  @override
  Widget build(BuildContext context) {
    List<_BarData> dataList = widget.usageInfos
        .map((info) => _BarData(Colors.blue, info.usage.inMinutes.toDouble(),
            info.usage.inMinutes.toDouble() + 5)) // Example data
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text('Top 7 App Usage Bar Chart')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: AspectRatio(
          aspectRatio: 1.4,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceBetween,
              maxY: 20, // You may need to adjust this based on your data
              titlesData: FlTitlesData(show: false),
              borderData: FlBorderData(show: false),
              barGroups: dataList.asMap().entries.map((e) {
                final index = e.key;
                final data = e.value;
                return BarChartGroupData(
                  x: index,
                  barRods: [
                    BarChartRodData(
                      toY: data.value,
                      color: data.color,
                      width: 22,
                      borderRadius: BorderRadius.circular(0),
                    )
                  ],
                  showingTooltipIndicators: [0],
                );
              }).toList(),
              barTouchData: BarTouchData(
                touchTooltipData: BarTouchTooltipData(
                  tooltipBgColor: Colors.blueGrey,
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    return BarTooltipItem(
                      rod.toY.round().toString(),
                      TextStyle(color: Colors.white),
                    );
                  },
                ),
                touchCallback: (FlTouchEvent event, barTouchResponse) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        barTouchResponse == null ||
                        barTouchResponse.spot == null) {
                      touchedGroupIndex = -1;
                      return;
                    }
                    touchedGroupIndex =
                        barTouchResponse.spot!.touchedBarGroupIndex;
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BarData {
  final Color color;
  final double value;
  final double shadowValue;

  _BarData(this.color, this.value, this.shadowValue);
}
