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
import 'package:flutter/material.dart';
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
}
