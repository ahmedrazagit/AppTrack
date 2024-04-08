/*import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_application_1/screens/flask.dart';
class PredictionChartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PredictionChartPageState();
}

class _PredictionChartPageState extends State<PredictionChartPage> {
  final List<double> _predictions =
      List.generate(24, (index) => 5.0 * (index / 23.0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Predictive Usage Chart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: LineChart(
          LineChartData(
            lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(
                tooltipBgColor: Colors.blueAccent,
              ),
              touchCallback: (LineTouchResponse touchResponse) {},
              handleBuiltInTouches: true,
            ),
            gridData: FlGridData(
              show: true,
              drawVerticalLine: true,
              horizontalInterval: 1,
              verticalInterval: 1,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: const Color(0xff37434d),
                  strokeWidth: 1,
                );
              },
              getDrawingVerticalLine: (value) {
                return FlLine(
                  color: const Color(0xff37434d),
                  strokeWidth: 1,
                );
              },
            ),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                showTitles: true,
                reservedSizePerTick: 35,
                getTextStyles: (context, value) => const TextStyle(
                  color: Color(0xff68737d),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                getTitles: (value) {
                  switch (value.toInt()) {
                    case 0:
                      return '0h';
                    case 6:
                      return '6h';
                    case 12:
                      return '12h';
                    case 18:
                      return '18h';
                    case 24:
                      return '24h';
                    default:
                      return '';
                  }
                },
                margin: 8,
              ),
              leftTitles: SideTitles(
                showTitles: true,
                getTextStyles: (context, value) => const TextStyle(
                  color: Color(0xff67727d),
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                getTitles: (value) {
                  switch (value.toInt()) {
                    case 1:
                      return '1hr';
                    case 3:
                      return '3hr';
                    case 5:
                      return '5hr';
                  }
                  return '';
                },
                reservedSize: 32,
                margin: 12,
              ),
            ),
            borderData: FlBorderData(
              show: true,
              border: Border.all(color: const Color(0xff37434d), width: 1),
            ),
            minX: 0,
            maxX: 23,
            minY: 0,
            maxY: 5,
            lineBarsData: [
              LineChartBarData(
                spots: _predictions
                    .asMap()
                    .entries
                    .map((e) => FlSpot(e.key.toDouble(), e.value))
                    .toList(),
                isCurved: true,
                colors: [Colors.blue],
                barWidth: 5,
                isStrokeCapRound: true,
                dotData: FlDotData(show: false),
                belowBarData: BarAreaData(show: false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/
/*
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_application_1/screens/flask.dart'; // Import your ApiService here

class PredictionGraphPage extends StatefulWidget {
  @override
  _PredictionGraphPageState createState() => _PredictionGraphPageState();
}

class _PredictionGraphPageState extends State<PredictionGraphPage> {
  List<double> mockData = List.generate(
      24, (index) => 5.0 * index / 23); // Mock data for the last 24 hours
  List<double> predictions = []; // Empty list for predictions

  /*@override
  void initState() {
    super.initState();
    ApiService().getPredictions(mockHourlyUsageData).then((fetchedPredictions) {
      setState(() {
        predictions = fetchedPredictions;
      });
    });
  }*/
  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    try {
      var fetchedPredictions = await ApiService().getPredictions(mockData);
      setState(() {
        predictions = fetchedPredictions;
      });
    } catch (e) {
      // Handle errors appropriately in your app context
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<FlSpot> spots = [];
    // Convert hourly data and predictions to FlSpot for plotting
    for (int i = 0; i < mockData.length; i++) {
      spots.add(FlSpot(i.toDouble(), mockData[i]));
    }
    for (int i = 0; i < predictions.length; i++) {
      spots.add(FlSpot((24 + i).toDouble(),
          predictions[i])); // Start from x=24 for predictions
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Hourly Usage and Predictions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: LineChart(
          LineChartData(
            gridData: FlGridData(show: false),
            titlesData: FlTitlesData(show: false),
            borderData: FlBorderData(show: false),
            lineBarsData: [
              LineChartBarData(
                spots: spots,
                isCurved: true,
                color: Colors.blueAccent,
                barWidth: 4,
                isStrokeCapRound: true,
                dotData: FlDotData(show: false),
                belowBarData: BarAreaData(show: false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/
/*import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_application_1/screens/flask.dart'; // Adjust the import path as necessary
import 'package:intl/intl.dart'; // Don't forget to add `intl` package in your pubspec.yaml

class PredictionGraphPage extends StatefulWidget {
  @override
  _PredictionGraphPageState createState() => _PredictionGraphPageState();
}

class _PredictionGraphPageState extends State<PredictionGraphPage> {
  List<double> mockData = List.generate(
      24, (index) => 5.0 * index / 23); // Mock data for the last 24 hours
  List<double> predictions = []; // Empty list for predictions
  bool _isDailyView = true; // Toggle between daily and weekly views

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    try {
      var fetchedPredictions = await ApiService().getPredictions(mockData);
      setState(() {
        predictions = fetchedPredictions;
      });
    } catch (e) {
      print(e); // Handle errors appropriately in your app context
    }
  }

  List<FlSpot> _generateSpots() {
    List<FlSpot> spots = [];
    for (int i = 0; i < mockData.length; i++) {
      spots.add(FlSpot(i.toDouble(), mockData[i]));
    }
    for (int i = 0; i < predictions.length; i++) {
      spots.add(FlSpot(
          (24 + i).toDouble(),
          predictions[
              i])); // Assuming predictions start right after the last mockData entry
    }
    return spots;
  }

  LineChartData _chartData() {
    double minY = _isDailyView ? 0 : 1;
    double maxY = _isDailyView ? 6 : 4;
    return LineChartData(
      minY: minY,
      maxY: maxY,
      lineBarsData: [
        LineChartBarData(
          spots: _generateSpots(),
          isCurved: true,
          color: Colors.blueAccent,
          barWidth: 2.5,
          isStrokeCapRound: true,
          dotData: FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                Colors.blueAccent.withOpacity(0.4),
                Colors.pinkAccent.withOpacity(0.4)
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ],
      // Additional configurations based on the provided method
      // Add other necessary configurations as per your requirements
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hourly Usage and Predictions'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: LineChart(_chartData()),
            ),
          ),
          // Toggle button for demonstration purposes
          TextButton(
            onPressed: () {
              setState(() {
                _isDailyView = !_isDailyView;
              });
            },
            child: Text(_isDailyView
                ? 'Switch to Weekly View'
                : 'Switch to Daily View'),
          ),
        ],
      ),
    );
  }
}*/

/*import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:app_usage/app_usage.dart';
import 'package:intl/intl.dart';
// Import your ApiService here
import 'package:flutter_application_1/screens/flask.dart'; // Adjust this import as per your project structure

class PredictionGraphPage extends StatefulWidget {
  @override
  _PredictionGraphPageState createState() => _PredictionGraphPageState();
}

class _PredictionGraphPageState extends State<PredictionGraphPage> {
  List<FlSpot> _spots = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUsageStatsAndPredictions();
  }

  Future<void> _loadUsageStatsAndPredictions() async {
    DateTime now = DateTime.now();
    DateTime startOfToday = DateTime(now.year, now.month, now.day);
    DateTime endOfToday = DateTime(now.year, now.month, now.day, 23, 59, 59);
    List<double> hourlyUsages = [];

    try {
      List<AppUsageInfo> infoList =
          await AppUsage().getAppUsage(startOfToday, endOfToday);
      // Aggregate hourly data
      Map<int, double> hourlyUsageMap = {};
      for (var info in infoList) {
        int hour = info.startDate.hour;
        double usageInHours = info.usage.inMinutes / 60.0;
        hourlyUsageMap.update(hour, (value) => value + usageInHours,
            ifAbsent: () => usageInHours);
      }

      // Ensure data for each hour, even if no usage
      for (int i = 0; i < 24; i++) {
        hourlyUsages.add(hourlyUsageMap[i] ?? 0.0);
      }

      _generateSpots(hourlyUsages); // Generate initial spots from usage data

      // Fetch predictions and append to spots
      List<double> predictions =
          await ApiService().getPredictions(hourlyUsages);
      _appendPredictionsToSpots(predictions);
    } catch (e) {
      print("Error fetching app usage and predictions: $e");
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _generateSpots(List<double> usages) {
    final List<FlSpot> spots = List.generate(
        usages.length, (index) => FlSpot(index.toDouble(), usages[index]));
    setState(() {
      _spots = spots;
    });
  }

  void _appendPredictionsToSpots(List<double> predictions) {
    final int startIndex = _spots.length;
    final List<FlSpot> predictionSpots = List.generate(predictions.length,
        (index) => FlSpot((startIndex + index).toDouble(), predictions[index]));
    setState(() {
      _spots.addAll(predictionSpots);
    });
  }

  LineChartData _chartData() {
    return LineChartData(
      minY: 0,
      maxY: _spots
          .map((e) => e.y)
          .reduce(max)
          .ceilToDouble(), // Dynamically adjust maxY based on the data
      lineBarsData: [
        LineChartBarData(
          spots: _spots,
          isCurved: true,
          color: Colors.blueAccent,
          barWidth: 2.5,
          isStrokeCapRound: true,
          dotData: FlDotData(show: false),
          belowBarData: BarAreaData(show: false),
        ),
      ],
      // Additional configurations here
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Usage and Predictions'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20),
              child: LineChart(_chartData()),
            ),
    );
  }
}*/

import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'package:app_usage/app_usage.dart';
import 'package:device_apps/device_apps.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_1/screens/flask.dart';

void main() => runApp(ScreenTimeApp());

class ScreenTimeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Screen Time',
      home: AppListPage(),
    );
  }
}

class AppListPage extends StatefulWidget {
  @override
  _AppListPageState createState() => _AppListPageState();
}

class _AppListPageState extends State<AppListPage> {
  List<ApplicationWithIcon> _apps = [];

  @override
  void initState() {
    super.initState();
    _loadApps();
  }

  Future<void> _loadApps() async {
    List<Application> apps = await DeviceApps.getInstalledApplications(
      onlyAppsWithLaunchIntent: true,
      includeAppIcons: true,
      includeSystemApps: true,
    );
    setState(() {
      _apps = apps.cast<ApplicationWithIcon>();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Installed Applications'),
      ),
      body: ListView.builder(
        itemCount: _apps.length,
        itemBuilder: (context, index) {
          ApplicationWithIcon app = _apps[index];
          return ListTile(
            leading: Image.memory(app.icon),
            title: Text(app.appName),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => PredictionGraphPage(
                    packageName: app.packageName, appName: app.appName),
              ),
            ),
          );
        },
      ),
    );
  }
}

class PredictionGraphPage extends StatefulWidget {
  final String packageName;
  final String appName;

  PredictionGraphPage({required this.packageName, required this.appName});

  @override
  _PredictionGraphPageState createState() => _PredictionGraphPageState();
}

class _PredictionGraphPageState extends State<PredictionGraphPage> {
  List<FlSpot> _actualUsageSpots = [];
  List<FlSpot> _predictionSpots = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUsageStatsAndPredictions();
  }

  Future<void> _loadUsageStatsAndPredictions() async {
    DateTime now = DateTime.now();
    DateTime startOfToday = DateTime(now.year, now.month, now.day);
    DateTime endOfToday = DateTime(now.year, now.month, now.day, 23, 59, 59);
    List<double> hourlyUsages = [];

    try {
      List<AppUsageInfo> infoList =
          await AppUsage().getAppUsage(startOfToday, endOfToday);
      // Aggregate hourly data
      Map<int, double> hourlyUsageMap = {};
      for (var info in infoList) {
        int hour = info.startDate.hour;
        double usageInHours = info.usage.inMinutes / 60.0;
        hourlyUsageMap.update(hour, (value) => value + usageInHours,
            ifAbsent: () => usageInHours);
      }

      // Ensure data for each hour, even if no usage
      for (int i = 0; i < 24; i++) {
        hourlyUsages.add(hourlyUsageMap[i] ?? 0.0);
      }

      // Generate initial spots from usage data
      List<FlSpot> actualUsageSpots = List.generate(hourlyUsages.length,
          (index) => FlSpot(index.toDouble(), hourlyUsages[index]));

      // Fetch predictions and generate spots
      List<double> predictions =
          await ApiService().getPredictions(hourlyUsages);
      List<FlSpot> predictionSpots = List.generate(predictions.length,
          (index) => FlSpot((24 + index).toDouble(), predictions[index]));

      setState(() {
        _actualUsageSpots = actualUsageSpots;
        _predictionSpots = predictionSpots;
        _isLoading = false;
      });
    } catch (e) {
      print("Error fetching app usage and predictions: $e");
    }
  }

  LineChartData _chartData() {
    return LineChartData(
      minY: 0,
      maxY: max(_actualUsageSpots.map((e) => e.y).reduce(max),
              _predictionSpots.map((e) => e.y).reduce(max))
          .ceilToDouble(), // Dynamically adjust maxY based on the data
      lineBarsData: [
        LineChartBarData(
          spots: _actualUsageSpots,
          isCurved: true,
          color: Colors.blueAccent,
          barWidth: 2.5,
          isStrokeCapRound: true,
          dotData: FlDotData(show: false),
          belowBarData: BarAreaData(show: false),
        ),
        LineChartBarData(
          spots: _predictionSpots,
          isCurved: true,
          color: Colors.green, // Prediction line in green
          barWidth: 2.5,
          isStrokeCapRound: true,
          dotData:
              FlDotData(show: true), // Optionally show dots for predictions
          belowBarData: BarAreaData(show: false),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.appName} Usage and Predictions'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20),
              child: LineChart(_chartData()),
            ),
    );
  }
}
