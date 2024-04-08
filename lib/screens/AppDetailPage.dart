/*import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Make sure to include intl for date formatting
import 'package:app_usage/app_usage.dart';

class AppDetailPage extends StatefulWidget {
  final String packageName;

  const AppDetailPage({Key? key, required this.packageName}) : super(key: key);

  @override
  _AppDetailPageState createState() => _AppDetailPageState();
}

class _AppDetailPageState extends State<AppDetailPage> {
  Map<String, Duration> _usagePerDay = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUsageStats();
  }

  Future<void> _loadUsageStats() async {
    DateTime endDate = DateTime.now();
    DateTime startDate =
        endDate.subtract(Duration(days: 6)); // Last 7 days including today

    try {
      List<AppUsageInfo> infoList =
          await AppUsage().getAppUsage(startDate, endDate);
      Map<String, Duration> usageMap = {};
      for (var i = 0; i < 7; i++) {
        DateTime day = startDate.add(Duration(days: i));
        String formattedDate = DateFormat('yyyy-MM-dd').format(day);
        // Filter infoList for this day, sum durations if necessary
        Duration totalDuration = Duration();
        for (var info in infoList) {
          if (info.packageName == widget.packageName) {
            totalDuration += info.usage;
          }
        }
        usageMap[formattedDate] = totalDuration;
      }
      setState(() {
        _usagePerDay = usageMap;
        _isLoading = false;
      });
    } on AppUsageException catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
    }
  }

  String _formatDuration(Duration duration) {
    return "${duration.inHours}h ${duration.inMinutes % 60}m ${duration.inSeconds % 60}s";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Usage Details'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _usagePerDay.length,
              itemBuilder: (context, index) {
                String date = _usagePerDay.keys.elementAt(index);
                Duration usageDuration = _usagePerDay.values.elementAt(index);
                return ListTile(
                  title: Text("Date: $date"),
                  subtitle: Text("Usage: ${_formatDuration(usageDuration)}"),
                );
              },
            ),
    );
  }
}*/
/*import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Make sure to include intl for date formatting
import 'package:app_usage/app_usage.dart';

class AppDetailPage extends StatefulWidget {
  final String packageName;

  const AppDetailPage({Key? key, required this.packageName}) : super(key: key);

  @override
  _AppDetailPageState createState() => _AppDetailPageState();
}

class _AppDetailPageState extends State<AppDetailPage> {
  Map<String, Duration> _usagePerDay = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUsageStats();
  }

  Future<void> _loadUsageStats() async {
    DateTime now = DateTime.now();
    Map<String, Duration> usageMap = {};

    // Initialize loading state
    setState(() {
      _isLoading = true;
    });

    for (int i = 6; i >= 0; i--) {
      // Calculate the start and end of each day in the last 7 days
      DateTime dayStart = DateTime(now.year, now.month, now.day - i);
      DateTime dayEnd = DateTime(now.year, now.month, now.day - i, 23, 59, 59);

      try {
        // Fetch usage info for each day
        List<AppUsageInfo> dailyInfoList =
            await AppUsage().getAppUsage(dayStart, dayEnd);
        Duration totalDuration = Duration();
        for (var info in dailyInfoList) {
          if (info.packageName == widget.packageName) {
            totalDuration += info.usage;
          }
        }

        // Format the date and store the total usage for that day
        String formattedDate = DateFormat('yyyy-MM-dd').format(dayStart);
        usageMap[formattedDate] = totalDuration;
      } on AppUsageException catch (e) {
        print(e);
      }
    }

    // Update state with the computed daily usage
    setState(() {
      _usagePerDay = usageMap;
      _isLoading = false;
    });
  }

  String _formatDuration(Duration duration) {
    return "${duration.inHours}h ${duration.inMinutes % 60}m ${duration.inSeconds % 60}s";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Usage Details'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _usagePerDay.length,
              itemBuilder: (context, index) {
                String date = _usagePerDay.keys.elementAt(index);
                Duration usageDuration = _usagePerDay.values.elementAt(index);
                return ListTile(
                  title: Text("Date: $date"),
                  subtitle: Text("Usage: ${_formatDuration(usageDuration)}"),
                );
              },
            ),
    );
  }
}*/

/*import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app_usage/app_usage.dart';

class AppDetailPage extends StatefulWidget {
  final String packageName;

  const AppDetailPage({Key? key, required this.packageName}) : super(key: key);

  @override
  _AppDetailPageState createState() => _AppDetailPageState();
}

class _AppDetailPageState extends State<AppDetailPage> {
  Map<String, Duration> _usageData = {};
  bool _isLoading = true;
  bool _isDailyView =
      false; // Toggle between daily (hourly breakdown) and weekly view

  @override
  void initState() {
    super.initState();
    _loadUsageStats();
  }

  Future<void> _loadUsageStats() async {
    DateTime now = DateTime.now();
    Map<String, Duration> usageMap = {};

    setState(() {
      _isLoading = true;
    });

    if (_isDailyView) {
      // Fetch hourly data for the last 24 hours
      DateTime startOfToday = DateTime(now.year, now.month, now.day, now.hour);
      for (int i = 23; i >= 0; i--) {
        DateTime startHour = startOfToday.subtract(Duration(hours: i));
        DateTime endHour =
            startHour.add(Duration(hours: 1)).subtract(Duration(seconds: 1));

        List<AppUsageInfo> infoList =
            await AppUsage().getAppUsage(startHour, endHour);
        Duration totalDuration = Duration();
        for (var info in infoList) {
          if (info.packageName == widget.packageName) {
            totalDuration += info.usage;
          }
        }

        // Use the start of the hour for labeling
        String formattedHour = DateFormat('HH:mm').format(startHour);
        usageMap[formattedHour] = totalDuration;
      }
    } else {
      // Load daily data for the last 7 days
      DateTime sevenDaysAgo = now.subtract(Duration(days: 6));
      for (int i = 0; i < 7; i++) {
        DateTime startOfDay = DateTime(
            sevenDaysAgo.year, sevenDaysAgo.month, sevenDaysAgo.day + i);
        DateTime endOfDay = DateTime(
            startOfDay.year, startOfDay.month, startOfDay.day, 23, 59, 59);

        List<AppUsageInfo> dailyInfoList =
            await AppUsage().getAppUsage(startOfDay, endOfDay);
        Duration totalDuration = Duration();
        for (var info in dailyInfoList) {
          if (info.packageName == widget.packageName) {
            totalDuration += info.usage;
          }
        }

        // Format the date for labeling
        String formattedDate = DateFormat('yyyy-MM-dd').format(startOfDay);
        usageMap[formattedDate] = totalDuration;
      }
    }

    setState(() {
      _usageData = usageMap;
      _isLoading = false;
    });
  }

  String _formatDuration(Duration duration) {
    return "${duration.inHours}h ${duration.inMinutes % 60}m ${duration.inSeconds % 60}s";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Usage Details'),
        actions: [
          IconButton(
            icon: Icon(_isDailyView
                ? Icons.calendar_view_day
                : Icons.calendar_view_week),
            onPressed: () {
              setState(() {
                _isDailyView = !_isDailyView;
                _loadUsageStats();
              });
            },
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _usageData.length,
              itemBuilder: (context, index) {
                String key = _usageData.keys.elementAt(index);
                Duration usage = _usageData.values.elementAt(index);
                return ListTile(
                  title: Text("Date/Time: $key"),
                  subtitle: Text("Usage: ${_formatDuration(usage)}"),
                );
              },
            ),
    );
  }
}*/

/*import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app_usage/app_usage.dart';
import 'package:fl_chart/fl_chart.dart';

class AppDetailPage extends StatefulWidget {
  final String packageName;

  const AppDetailPage({Key? key, required this.packageName}) : super(key: key);

  @override
  _AppDetailPageState createState() => _AppDetailPageState();
}

class _AppDetailPageState extends State<AppDetailPage> {
  Map<String, Duration> _usageData = {};
  bool _isLoading = true;
  bool _isDailyView = false;

  @override
  void initState() {
    super.initState();
    _loadUsageStats();
  }

  Future<void> _loadUsageStats() async {
    // Implementation remains the same as your previous _loadUsageStats method
    DateTime now = DateTime.now();
    Map<String, Duration> usageMap = {};

    setState(() {
      _isLoading = true;
    });

    if (_isDailyView) {
      // Fetch hourly data for the last 24 hours
      DateTime startOfToday = DateTime(now.year, now.month, now.day, now.hour);
      for (int i = 23; i >= 0; i--) {
        DateTime startHour = startOfToday.subtract(Duration(hours: i));
        DateTime endHour =
            startHour.add(Duration(hours: 1)).subtract(Duration(seconds: 1));

        List<AppUsageInfo> infoList =
            await AppUsage().getAppUsage(startHour, endHour);
        Duration totalDuration = Duration();
        for (var info in infoList) {
          if (info.packageName == widget.packageName) {
            totalDuration += info.usage;
          }
        }

        // Use the start of the hour for labeling
        String formattedHour = DateFormat('HH:mm').format(startHour);
        usageMap[formattedHour] = totalDuration;
      }
    } else {
      // Load daily data for the last 7 days
      DateTime sevenDaysAgo = now.subtract(Duration(days: 6));
      for (int i = 0; i < 7; i++) {
        DateTime startOfDay = DateTime(
            sevenDaysAgo.year, sevenDaysAgo.month, sevenDaysAgo.day + i);
        DateTime endOfDay = DateTime(
            startOfDay.year, startOfDay.month, startOfDay.day, 23, 59, 59);

        List<AppUsageInfo> dailyInfoList =
            await AppUsage().getAppUsage(startOfDay, endOfDay);
        Duration totalDuration = Duration();
        for (var info in dailyInfoList) {
          if (info.packageName == widget.packageName) {
            totalDuration += info.usage;
          }
        }

        // Format the date for labeling
        String formattedDate = DateFormat('yyyy-MM-dd').format(startOfDay);
        usageMap[formattedDate] = totalDuration;
      }
    }

    setState(() {
      _usageData = usageMap;
      _isLoading = false;
    });
  }

  String _formatDuration(Duration duration) {
    return "${duration.inHours}h ${duration.inMinutes % 60}m ${duration.inSeconds % 60}s";
  }

  List<FlSpot> _generateSpots() {
    final List<FlSpot> spots = [];
    int index = 0; // Use an index for the x-axis in the daily view

    _usageData.forEach((key, duration) {
      final hours = duration.inMinutes / 60.0;
      double xValue = index.toDouble(); // Use index as xValue for both views

      if (!_isDailyView) {
        // If it's a weekly view, you might want to parse the date and extract something like day of month
        final date = DateFormat('yyyy-MM-dd').parse(key);
        xValue = date.day
            .toDouble(); // For example, using day of month for weekly view xValue
      }

      spots.add(FlSpot(xValue, hours));
      index++; // Increment index regardless of view type
    });

    return spots;
  }

/*
  LineChartData _chartData() {
    return LineChartData(
      gridData: FlGridData(show: false),
      titlesData: FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              // Customize based on your data
              return Text(
                _isDailyView ? '${value.toInt()}:00' : 'Day ${value.toInt()}',
                style: TextStyle(color: Colors.black, fontSize: 10),
              );
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 40, // Adjust if necessary
            interval: 1, // Adjust according to your data range
            getTitlesWidget: (value, meta) {
              // Format y-axis labels as minutes
              return Text('${value.toInt()} min',
                  style: TextStyle(color: Colors.black, fontSize: 10));
            },
          ),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
          show: true, border: Border.all(color: Colors.grey.withOpacity(0.5))),
      lineBarsData: [
        LineChartBarData(
          spots: _generateSpots(),
          isCurved: true,
          color: Colors.blueAccent,
          barWidth: 2,
          dotData: FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                Colors.blueAccent.withOpacity(0.4),
                Colors.pinkAccent.withOpacity(0.4),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ],
    );
  }
*/
  LineChartData _chartData() {
    // Define minY and maxY for the chart based on the view
    double minY =
        _isDailyView ? 0 : 1; // Start from 0 for daily, 1 hour for weekly
    double maxY = _isDailyView
        ? 6
        : 4; // Up to 60 minutes (6 * 10min intervals) for daily, 4 hours for weekly

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
                Colors.pinkAccent.withOpacity(0.4),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ],
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              if (_isDailyView) {
                // Assuming value represents hours for daily view
                return Text(
                    '${(value.toInt() % 24).toString().padLeft(2, '0')}:00');
              } else {
                // Weekly view: Show days
                DateTime day =
                    DateTime.now().subtract(Duration(days: value.toInt()));
                return Text(DateFormat('E')
                    .format(day)); // Short day format (e.g., Mon, Tue)
              }
            },
            reservedSize: 42,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              // Y-axis labels based on the view
              if (_isDailyView) {
                return Text(
                    '${(value * 10).toInt()}m'); // Daily: minutes in 10min intervals
              } else {
                return Text('${value.toInt()}h'); // Weekly: hours
              }
            },
            interval:
                1, // Ensure labels are shown for each hour/10 minutes interval
            reservedSize: 28,
          ),
        ),
      ),
      gridData: FlGridData(show: false),
      borderData: FlBorderData(show: false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Usage Details'),
        actions: [
          IconButton(
            icon: Icon(_isDailyView
                ? Icons.calendar_view_day
                : Icons.calendar_view_week),
            onPressed: () {
              setState(() {
                _isDailyView = !_isDailyView;
                _loadUsageStats();
              });
            },
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                AspectRatio(
                  aspectRatio: 1.7,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: LineChart(_chartData()),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _usageData.length,
                    itemBuilder: (context, index) {
                      String key = _usageData.keys.elementAt(index);
                      Duration usage = _usageData.values.elementAt(index);
                      return ListTile(
                        title: Text("Date/Time: $key"),
                        subtitle: Text("Usage: ${_formatDuration(usage)}"),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}*/

/*import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app_usage/app_usage.dart';
import 'package:fl_chart/fl_chart.dart';
// Assume AIAnalysisService is in ai_analysis_service.dart
import 'package:flutter_application_1/screens/ai_analysis.dart';

class AppDetailPage extends StatefulWidget {
  final String packageName;

  const AppDetailPage({Key? key, required this.packageName}) : super(key: key);

  @override
  _AppDetailPageState createState() => _AppDetailPageState();
}

class _AppDetailPageState extends State<AppDetailPage> {
  Map<String, Duration> _usageData = {};
  bool _isLoading = true;
  bool _isDailyView = false;

  final AIAnalysisService _aiAnalysisService = AIAnalysisService();

  @override
  void initState() {
    super.initState();
    _loadUsageStats();
  }

  Future<void> _loadUsageStats() async {
    // Implementation remains the same as your previous _loadUsageStats method
    DateTime now = DateTime.now();
    Map<String, Duration> usageMap = {};

    setState(() {
      _isLoading = true;
    });

    if (_isDailyView) {
      // Fetch hourly data for the last 24 hours
      DateTime startOfToday = DateTime(now.year, now.month, now.day, now.hour);
      for (int i = 23; i >= 0; i--) {
        DateTime startHour = startOfToday.subtract(Duration(hours: i));
        DateTime endHour =
            startHour.add(Duration(hours: 1)).subtract(Duration(seconds: 1));

        List<AppUsageInfo> infoList =
            await AppUsage().getAppUsage(startHour, endHour);
        Duration totalDuration = Duration();
        for (var info in infoList) {
          if (info.packageName == widget.packageName) {
            totalDuration += info.usage;
          }
        }

        // Use the start of the hour for labeling
        String formattedHour = DateFormat('HH:mm').format(startHour);
        usageMap[formattedHour] = totalDuration;
      }
    } else {
      // Load daily data for the last 7 days
      DateTime sevenDaysAgo = now.subtract(Duration(days: 6));
      for (int i = 0; i < 7; i++) {
        DateTime startOfDay = DateTime(
            sevenDaysAgo.year, sevenDaysAgo.month, sevenDaysAgo.day + i);
        DateTime endOfDay = DateTime(
            startOfDay.year, startOfDay.month, startOfDay.day, 23, 59, 59);

        List<AppUsageInfo> dailyInfoList =
            await AppUsage().getAppUsage(startOfDay, endOfDay);
        Duration totalDuration = Duration();
        for (var info in dailyInfoList) {
          if (info.packageName == widget.packageName) {
            totalDuration += info.usage;
          }
        }

        // Format the date for labeling
        String formattedDate = DateFormat('yyyy-MM-dd').format(startOfDay);
        usageMap[formattedDate] = totalDuration;
      }
    }

    setState(() {
      _usageData = usageMap;
      _isLoading = false;
    });
  }

  String _formatDuration(Duration duration) {
    return "${duration.inHours}h ${duration.inMinutes % 60}m ${duration.inSeconds % 60}s";
  }

  List<FlSpot> _generateSpots() {
    final List<FlSpot> spots = [];
    int index = 0; // Use an index for the x-axis in the daily view

    _usageData.forEach((key, duration) {
      final hours = duration.inMinutes / 60.0;
      double xValue = index.toDouble(); // Use index as xValue for both views

      if (!_isDailyView) {
        // If it's a weekly view, you might want to parse the date and extract something like day of month
        final date = DateFormat('yyyy-MM-dd').parse(key);
        xValue = date.day
            .toDouble(); // For example, using day of month for weekly view xValue
      }

      spots.add(FlSpot(xValue, hours));
      index++; // Increment index regardless of view type
    });

    return spots;
  }

  LineChartData _chartData() {
    // Define minY and maxY for the chart based on the view
    double minY =
        _isDailyView ? 0 : 1; // Start from 0 for daily, 1 hour for weekly
    double maxY = _isDailyView
        ? 6
        : 4; // Up to 60 minutes (6 * 10min intervals) for daily, 4 hours for weekly

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
                Colors.pinkAccent.withOpacity(0.4),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ],
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              if (_isDailyView) {
                // Assuming value represents hours for daily view
                return Text(
                    '${(value.toInt() % 24).toString().padLeft(2, '0')}:00');
              } else {
                // Weekly view: Show days
                DateTime day =
                    DateTime.now().subtract(Duration(days: value.toInt()));
                return Text(DateFormat('E')
                    .format(day)); // Short day format (e.g., Mon, Tue)
              }
            },
            reservedSize: 42,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              // Y-axis labels based on the view
              if (_isDailyView) {
                return Text(
                    '${(value * 10).toInt()}m'); // Daily: minutes in 10min intervals
              } else {
                return Text('${value.toInt()}h'); // Weekly: hours
              }
            },
            interval:
                1, // Ensure labels are shown for each hour/10 minutes interval
            reservedSize: 28,
          ),
        ),
      ),
      gridData: FlGridData(show: false),
      borderData: FlBorderData(show: false),
    );
  }

  void _showAIAnalysis(BuildContext context) async {
    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: <Widget>[
              CircularProgressIndicator(),
              Container(
                  margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
            ],
          ),
        );
      },
    );

    // Construct a meaningful prompt based on the app usage data
    String prompt =
        "Provide an analysis and recommendations for app usage based on the following data: ";
    prompt += _usageData.entries
        .map((entry) => "${entry.key}: ${_formatDuration(entry.value)}")
        .join(", ");

    // Fetch analysis
    try {
      final analysis = await _aiAnalysisService.getAnalysis(prompt);
      Navigator.pop(context); // Close the loading dialog

      // Show analysis result
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("AI Analysis"),
            content: SingleChildScrollView(child: Text(analysis)),
            actions: <Widget>[
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      Navigator.pop(context); // Close the loading dialog
      print("Error fetching AI analysis: $e");
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Usage Details'),
        actions: [
          IconButton(
            icon: Icon(_isDailyView
                ? Icons.calendar_view_day
                : Icons.calendar_view_week),
            onPressed: () {
              setState(() {
                _isDailyView = !_isDailyView;
                _loadUsageStats();
              });
            },
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                AspectRatio(
                  aspectRatio: 1.7,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: LineChart(_chartData()),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ElevatedButton(
                    onPressed: () => _showAIAnalysis(context),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      primary: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.blueAccent, Colors.pinkAccent],
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Text(
                          "AI Analysis",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _usageData.length,
                    itemBuilder: (context, index) {
                      String key = _usageData.keys.elementAt(index);
                      Duration usage = _usageData.values.elementAt(index);
                      return ListTile(
                        title: Text("Date/Time: $key"),
                        subtitle: Text("Usage: ${_formatDuration(usage)}"),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}*/
/*
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app_usage/app_usage.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart'; // Make sure this import is correct
import 'package:flutter_application_1/screens/const.dart'; // This should contain your OpenAI API key

class AppDetailPage extends StatefulWidget {
  final String packageName;

  const AppDetailPage({Key? key, required this.packageName}) : super(key: key);

  get isDailyView => null;

  @override
  _AppDetailPageState createState() => _AppDetailPageState();
}

class _AppDetailPageState extends State<AppDetailPage> {
  Map<String, Duration> _usageData = {};
  bool _isLoading = true;
  bool _isDailyView = false;
  late OpenAI openAI;

  @override
  void initState() {
    super.initState();
    _loadUsageStats();
    _initializeOpenAI();
  }

  void _initializeOpenAI() {
    openAI = OpenAI.instance.build(
      token: OPENAI_API_KEY,
      baseOption: HttpSetup(
        receiveTimeout: const Duration(seconds: 20),
        connectTimeout: const Duration(seconds: 20),
      ),
      enableLog: true,
    );
  }

  // Include your existing _loadUsageStats, _formatDuration, _generateSpots, and _chartData methods here
  Future<void> _loadUsageStats() async {
    // Implementation remains the same as your previous _loadUsageStats method
    DateTime now = DateTime.now();
    Map<String, Duration> usageMap = {};

    setState(() {
      _isLoading = true;
    });

    if (_isDailyView) {
      // Fetch hourly data for the last 24 hours
      DateTime startOfToday = DateTime(now.year, now.month, now.day, now.hour);
      for (int i = 23; i >= 0; i--) {
        DateTime startHour = startOfToday.subtract(Duration(hours: i));
        DateTime endHour =
            startHour.add(Duration(hours: 1)).subtract(Duration(seconds: 1));

        List<AppUsageInfo> infoList =
            await AppUsage().getAppUsage(startHour, endHour);
        Duration totalDuration = Duration();
        for (var info in infoList) {
          if (info.packageName == widget.packageName) {
            totalDuration += info.usage;
          }
        }

        // Use the start of the hour for labeling
        String formattedHour = DateFormat('HH:mm').format(startHour);
        usageMap[formattedHour] = totalDuration;
      }
    } else {
      // Load daily data for the last 7 days
      DateTime sevenDaysAgo = now.subtract(Duration(days: 6));
      for (int i = 0; i < 7; i++) {
        DateTime startOfDay = DateTime(
            sevenDaysAgo.year, sevenDaysAgo.month, sevenDaysAgo.day + i);
        DateTime endOfDay = DateTime(
            startOfDay.year, startOfDay.month, startOfDay.day, 23, 59, 59);

        List<AppUsageInfo> dailyInfoList =
            await AppUsage().getAppUsage(startOfDay, endOfDay);
        Duration totalDuration = Duration();
        for (var info in dailyInfoList) {
          if (info.packageName == widget.packageName) {
            totalDuration += info.usage;
          }
        }

        // Format the date for labeling
        String formattedDate = DateFormat('yyyy-MM-dd').format(startOfDay);
        usageMap[formattedDate] = totalDuration;
      }
    }

    setState(() {
      _usageData = usageMap;
      _isLoading = false;
    });
  }

  String _formatDuration(Duration duration) {
    return "${duration.inHours}h ${duration.inMinutes % 60}m ${duration.inSeconds % 60}s";
  }

  List<FlSpot> _generateSpots() {
    final List<FlSpot> spots = [];
    int index = 0; // Use an index for the x-axis in the daily view

    _usageData.forEach((key, duration) {
      final hours = duration.inMinutes / 60.0;
      double xValue = index.toDouble(); // Use index as xValue for both views

      if (!_isDailyView) {
        // If it's a weekly view, you might want to parse the date and extract something like day of month
        final date = DateFormat('yyyy-MM-dd').parse(key);
        xValue = date.day
            .toDouble(); // For example, using day of month for weekly view xValue
      }

      spots.add(FlSpot(xValue, hours));
      index++; // Increment index regardless of view type
    });

    return spots;
  }

  LineChartData _chartData() {
    // Define minY and maxY for the chart based on the view
    double minY =
        _isDailyView ? 0 : 1; // Start from 0 for daily, 1 hour for weekly
    double maxY = _isDailyView
        ? 6
        : 4; // Up to 60 minutes (6 * 10min intervals) for daily, 4 hours for weekly

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
                Colors.pinkAccent.withOpacity(0.4),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ],
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              if (_isDailyView) {
                // Assuming value represents hours for daily view
                return Text(
                    '${(value.toInt() % 24).toString().padLeft(2, '0')}:00');
              } else {
                // Weekly view: Show days
                DateTime day =
                    DateTime.now().subtract(Duration(days: value.toInt()));
                return Text(DateFormat('E')
                    .format(day)); // Short day format (e.g., Mon, Tue)
              }
            },
            reservedSize: 42,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              // Y-axis labels based on the view
              if (_isDailyView) {
                return Text(
                    '${(value * 10).toInt()}m'); // Daily: minutes in 10min intervals
              } else {
                return Text('${value.toInt()}h'); // Weekly: hours
              }
            },
            interval:
                1, // Ensure labels are shown for each hour/10 minutes interval
            reservedSize: 28,
          ),
        ),
      ),
      gridData: FlGridData(show: false),
      borderData: FlBorderData(show: false),
    );
  }

  void _showAIAnalysis(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(width: 10),
              Text("Analyzing..."),
            ],
          ),
        );
      },
    );

    String prompt =
        "Provide an analysis and recommendations based on the app usage data:\n";
    _usageData.forEach((key, value) {
      prompt += "$key: ${_formatDuration(value)}\n";
    });

    final request = ChatCompleteText(
      messages: [Messages(role: Role.user, content: prompt)],
      maxToken: 200,
      model: GptTurbo0301ChatModel(), // Adjust the model as needed
    );

    try {
      ChatCTResponse? response =
          await openAI.onChatCompletion(request: request);
      Navigator.of(context).pop(); // Close the analyzing dialog

      // Use a new BuildContext to ensure the dialog can be closed properly
      showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          // Notice the new dialogContext
          return AlertDialog(
            title: Text("AI Analysis"),
            content: SingleChildScrollView(
              child: Text(
                  response?.choices.first.message?.content ?? "No response"),
            ),
            actions: <Widget>[
              TextButton(
                child: Text("Close"),
                onPressed: () {
                  Navigator.pop(
                      dialogContext); // Use dialogContext to close the dialog
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      Navigator.pop(context); // Close the analyzing dialog if an error occurs
      print("Error fetching AI analysis: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Usage Details'),
        actions: [
          IconButton(
            icon: Icon(_isDailyView
                ? Icons.calendar_view_day
                : Icons.calendar_view_week),
            onPressed: () {
              setState(() {
                _isDailyView = !_isDailyView;
                _loadUsageStats();
              });
            },
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                AspectRatio(
                  aspectRatio: 1.7,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: LineChart(_chartData()),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ElevatedButton(
                    onPressed: () => _showAIAnalysis(context),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      primary: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.blueAccent, Colors.pinkAccent],
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Text(
                          "AI Analysis",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _usageData.length,
                    itemBuilder: (context, index) {
                      String key = _usageData.keys.elementAt(index);
                      Duration usage = _usageData.values.elementAt(index);
                      return ListTile(
                        title: Text("Date/Time: $key"),
                        subtitle: Text("Usage: ${_formatDuration(usage)}"),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
*/

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app_usage/app_usage.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart'; // Make sure this import is correct
import 'package:flutter_application_1/screens/const.dart'; // This should contain your OpenAI API key

class AppDetailPage extends StatefulWidget {
  final String packageName;

  const AppDetailPage({Key? key, required this.packageName}) : super(key: key);

  @override
  _AppDetailPageState createState() => _AppDetailPageState();
}

class _AppDetailPageState extends State<AppDetailPage> {
  Map<String, Duration> _usageData = {};
  bool _isLoading = true;
  bool _isDailyView = true; // Changed default view to true for daily view
  late OpenAI openAI;

  @override
  void initState() {
    super.initState();
    _loadUsageStats();
    _initializeOpenAI();
  }

  void _initializeOpenAI() {
    openAI = OpenAI.instance.build(
      token: OPENAI_API_KEY,
      baseOption: HttpSetup(
        receiveTimeout: const Duration(seconds: 20),
        connectTimeout: const Duration(seconds: 20),
      ),
      enableLog: true,
    );
  }

  Future<void> _loadUsageStats() async {
    DateTime now = DateTime.now();
    Map<String, Duration> usageMap = {};

    setState(() {
      _isLoading = true;
    });

    if (_isDailyView) {
      DateTime startOfToday = DateTime(now.year, now.month, now.day, now.hour);
      for (int i = 23; i >= 0; i--) {
        DateTime startHour = startOfToday.subtract(Duration(hours: i));
        DateTime endHour =
            startHour.add(Duration(hours: 1)).subtract(Duration(seconds: 1));

        List<AppUsageInfo> infoList =
            await AppUsage().getAppUsage(startHour, endHour);
        Duration totalDuration = Duration();
        for (var info in infoList) {
          if (info.packageName == widget.packageName) {
            totalDuration += info.usage;
          }
        }

        String formattedHour = DateFormat('HH:mm').format(startHour);
        usageMap[formattedHour] = totalDuration;
      }
    } else {
      DateTime sevenDaysAgo = now.subtract(Duration(days: 6));
      for (int i = 0; i < 7; i++) {
        DateTime startOfDay = DateTime(
            sevenDaysAgo.year, sevenDaysAgo.month, sevenDaysAgo.day + i);
        DateTime endOfDay = DateTime(
            startOfDay.year, startOfDay.month, startOfDay.day, 23, 59, 59);

        List<AppUsageInfo> dailyInfoList =
            await AppUsage().getAppUsage(startOfDay, endOfDay);
        Duration totalDuration = Duration();
        for (var info in dailyInfoList) {
          if (info.packageName == widget.packageName) {
            totalDuration += info.usage;
          }
        }

        String formattedDate = DateFormat('yyyy-MM-dd').format(startOfDay);
        usageMap[formattedDate] = totalDuration;
      }
    }

    setState(() {
      _usageData = usageMap;
      _isLoading = false;
    });
  }

  String _formatDuration(Duration duration) {
    return "${duration.inHours}h ${duration.inMinutes % 60}m ${duration.inSeconds % 60}s";
  }

  void _showAIAnalysis(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(width: 10),
              Text("Analyzing..."),
            ],
          ),
        );
      },
    );

    String prompt =
        "Do not mention you are an AI model.Provide an analysis of the data app usage data in terms of the user using this app, derive insights such as peak usages and times when they were most active, then give suggestions on how the user can decrease their screentime usage such as using the Applock feature within this app:\n";
    _usageData.forEach((key, value) {
      prompt += "$key: ${_formatDuration(value)}\n";
    });

    final request = ChatCompleteText(
      messages: [Messages(role: Role.user, content: prompt)],
      maxToken: 200,
      model: GptTurbo0301ChatModel(), // Adjust the model as needed
    );

    try {
      ChatCTResponse? response =
          await openAI.onChatCompletion(request: request);
      Navigator.of(context).pop(); // Close the analyzing dialog

      // Use a new BuildContext to ensure the dialog can be closed properly
      showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          // Notice the new dialogContext
          return AlertDialog(
            title: Text("AI Analysis"),
            content: SingleChildScrollView(
              child: Text(
                  response?.choices.first.message?.content ?? "No response"),
            ),
            actions: <Widget>[
              TextButton(
                child: Text("Close"),
                onPressed: () {
                  Navigator.pop(
                      dialogContext); // Use dialogContext to close the dialog
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      Navigator.pop(context); // Close the analyzing dialog if an error occurs
      print("Error fetching AI analysis: $e");
    }
  }

  List<FlSpot> _generateSpots() {
    final List<FlSpot> spots = [];
    int index = 0;

    _usageData.forEach((key, duration) {
      final hours = duration.inMinutes / 60.0;
      double xValue = index.toDouble();

      if (!_isDailyView) {
        final date = DateFormat('yyyy-MM-dd').parse(key);
        xValue = date.day.toDouble();
      }

      spots.add(FlSpot(xValue, hours));
      index++;
    });

    return spots;
  }

  LineChartData _chartData() {
    double minY = 0;
    double maxY = _usageData.values
        .map((duration) => duration.inMinutes / 60.0)
        .reduce(max)
        .ceilToDouble();
    maxY +=
        maxY * 0.1; // Increase maxY by 10% for some space above the highest bar

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
          belowBarData: BarAreaData(show: false),
        ),
      ],
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              if (_isDailyView) {
                return Text('${value.toInt() % 24}:00');
              } else {
                DateTime day =
                    DateTime.now().subtract(Duration(days: value.toInt()));
                return Text(DateFormat('E').format(day));
              }
            },
            reservedSize: 42,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) => Text('${value.toInt()}h'),
            interval: 1,
            reservedSize: 28,
          ),
        ),
      ),
      gridData: FlGridData(show: false),
      borderData: FlBorderData(show: false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Usage Details'),
        actions: [
          // Replaced IconButton with a more descriptive Button
          Container(
            margin: EdgeInsets.only(right: 8),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _isDailyView = !_isDailyView;
                  _loadUsageStats();
                });
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
              ),
              child: Text(_isDailyView ? "Weekly" : "Hourly"),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                AspectRatio(
                  aspectRatio: 1.7,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: LineChart(_chartData()),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ElevatedButton(
                    onPressed: () => _showAIAnalysis(context),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      primary: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.blueAccent, Colors.pinkAccent],
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Text(
                          "AI Analysis",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _usageData.length,
                    itemBuilder: (context, index) {
                      String key = _usageData.keys.elementAt(index);
                      Duration usage = _usageData.values.elementAt(index);
                      return ListTile(
                        title: Text("Date/Time: $key"),
                        subtitle: Text("Usage: ${_formatDuration(usage)}"),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
