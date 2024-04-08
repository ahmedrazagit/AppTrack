/*import 'package:flutter/material.dart';

class FeedbackPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback'),
      ),
      body: Center(
        child: Text(
          'FeedbackPage',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}*/

/*import 'package:flutter/material.dart';
import 'package:app_usage/app_usage.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter_application_1/screens/AppDetailPage.dart';

void main() => runApp(screentime());

class screentime extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<screentime> {
  List<AppUsageInfo> _usageInfos = [];
  List<ApplicationWithIcon> _installedApps = [];

  @override
  void initState() {
    super.initState();
    _loadInstalledApps();
    _getUsageStats();
  }

  Future<void> _loadInstalledApps() async {
    List<Application> apps = await DeviceApps.getInstalledApplications(
      onlyAppsWithLaunchIntent: true,
      includeAppIcons: true,
      includeSystemApps: true,
    );
    setState(() {
      _installedApps = apps.cast<ApplicationWithIcon>();
    });
  }

  Future<void> _getUsageStats() async {
    try {
      DateTime endDate = DateTime.now();
      DateTime startDate = DateTime(endDate.year, endDate.month, endDate.day);
      List<AppUsageInfo> infoList = await AppUsage().getAppUsage(
        startDate,
        endDate,
      );
      setState(() {
        _usageInfos = infoList;
      });
    } on AppUsageException catch (exception) {
      print(exception);
    }
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitHours = twoDigits(duration.inHours.remainder(24));
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigitHours}h ${twoDigitMinutes}m ${twoDigitSeconds}s";
  }

  String getScreenTime(String packageName) {
    // Iterating manually to find the matching app usage info
    for (final info in _usageInfos) {
      if (info.packageName == packageName) {
        return formatDuration(info.usage);
      }
    }
    // Return "0h 0m 0s" if no matching info is found
    return "0h 0m 0s";
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('App Usage Example'),
          backgroundColor: Colors.green,
        ),
        body: ListView.builder(
          itemCount: _installedApps.length,
          itemBuilder: (context, index) {
            ApplicationWithIcon app = _installedApps[index];
            String screenTime = getScreenTime(app.packageName);

            return ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(app.appName),
                  Text(
                    screenTime,
                    style: TextStyle(fontSize: 12.0, color: Colors.grey),
                  ),
                ],
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
              leading: Container(
                width: 48.0,
                child: app is ApplicationWithIcon
                    ? Image.memory(app.icon)
                    : Icon(Icons.error),
              ),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      AppDetailPage(packageName: app.packageName),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}*/

/*import 'dart:typed_data';
import 'package:app_usage/app_usage.dart';
import 'package:device_apps/device_apps.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

void main() => runApp(screentime());

class screentime extends StatefulWidget {
  @override
  _screentimeState createState() => _screentimeState();
}

class _screentimeState extends State<screentime> {
  List<AppUsageInfo> _usageInfos = [];
  List<ApplicationWithIcon> _installedApps = [];
  List<PieChartSectionData> _sections = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await _loadInstalledApps();
    await _getUsageStats();
    _preparePieChartData();
  }

  Future<void> _loadInstalledApps() async {
    List<Application> apps = await DeviceApps.getInstalledApplications(
      onlyAppsWithLaunchIntent: true,
      includeAppIcons: true,
      includeSystemApps: false,
    );
    setState(() {
      _installedApps = apps.cast<ApplicationWithIcon>();
    });
  }

  Future<void> _getUsageStats() async {
    try {
      DateTime endDate = DateTime.now();
      DateTime startDate = DateTime(endDate.year, endDate.month, endDate.day)
          .subtract(Duration(days: 1));
      AppUsage appUsage = AppUsage();
      List<AppUsageInfo> infoList =
          await appUsage.getAppUsage(startDate, endDate);
      setState(() {
        _usageInfos = infoList;
      });
    } catch (exception) {
      print(exception);
    }
  }

  void _preparePieChartData() {
    final List<PieChartSectionData> sections = [];
    final Map<String, double> usageMap = {};

    for (var appUsage in _usageInfos) {
      usageMap[appUsage.packageName] = appUsage.usage.inMinutes.toDouble();
    }

    int index = 0;
    _installedApps.forEach((app) {
      final usage = usageMap[app.packageName] ?? 0;
      if (usage > 0) {
        final section = PieChartSectionData(
          color: Colors.primaries[index % Colors.primaries.length],
          value: usage,
          title: '${usage.toStringAsFixed(1)}m',
          radius: 50,
          badgeWidget:
              _BadgeWidget(app.icon, size: 18, borderColor: Colors.white),
          badgePositionPercentageOffset: .98,
        );
        sections.add(section);
        index++;
      }
    });

    setState(() {
      _sections = sections;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('App Usage Stats'),
          backgroundColor: Colors.blueAccent,
        ),
        body: _sections.isNotEmpty
            ? Center(
                child: PieChart(
                  PieChartData(
                    sections: _sections,
                    centerSpaceRadius: 48,
                    sectionsSpace: 2,
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}

class _BadgeWidget extends StatelessWidget {
  final Uint8List icon;
  final double size;
  final Color borderColor;

  const _BadgeWidget(this.icon,
      {required this.size, required this.borderColor});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: borderColor,
      child: CircleAvatar(
        radius: size,
        backgroundImage: MemoryImage(icon),
      ),
    );
  }
}
*/

/*import 'dart:typed_data';
import 'package:app_usage/app_usage.dart';
import 'package:device_apps/device_apps.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/AppDetailPage.dart';

void main() => runApp(screentime());

class screentime extends StatefulWidget {
  @override
  _screentimeState createState() => _screentimeState();
}

class _screentimeState extends State<screentime> {
  List<AppUsageInfo> _usageInfos = [];
  List<ApplicationWithIcon> _installedApps = [];
  List<PieChartSectionData> _sections = [];
  int _touchedIndex = -1;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await _loadInstalledApps();
    await _getUsageStats();
    _preparePieChartData();
  }

  Future<void> _loadInstalledApps() async {
    List<Application> apps = await DeviceApps.getInstalledApplications(
      onlyAppsWithLaunchIntent: true,
      includeAppIcons: true,
      includeSystemApps: true,
    );
    setState(() {
      _installedApps = apps.cast<ApplicationWithIcon>();
    });
  }

  Future<void> _getUsageStats() async {
    try {
      DateTime endDate = DateTime.now();
      DateTime startDate = DateTime(endDate.year, endDate.month, endDate.day)
          .subtract(Duration(days: 1));
      AppUsage appUsage = AppUsage();
      List<AppUsageInfo> infoList =
          await appUsage.getAppUsage(startDate, endDate);
      setState(() {
        _usageInfos = infoList;
      });
    } catch (exception) {
      print(exception);
    }
  }

  String getScreenTime(String packageName) {
    // Iterating manually to find the matching app usage info
    for (final info in _usageInfos) {
      if (info.packageName == packageName) {
        return formatDuration(info.usage);
      }
    }
    // Return "0h 0m 0s" if no matching info is found
    return "0h 0m 0s";
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitHours = twoDigits(duration.inHours.remainder(24));
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigitHours}h ${twoDigitMinutes}m ${twoDigitSeconds}s";
  }

  void _preparePieChartData() {
    final Map<String, double> usageMap = {};
    _usageInfos.forEach((info) {
      usageMap[info.packageName] = info.usage.inMinutes.toDouble();
    });

    List<PieChartSectionData> sections = [];
    _installedApps.forEach((app) {
      final appName = app.appName;
      final usage = usageMap[app.packageName] ?? 0.0;
      if (usage > 0) {
        final sectionIndex = sections.length;
        final isTouched = sectionIndex == _touchedIndex;
        final fontSize = isTouched ? 18.0 : 16.0;
        final radius = isTouched ? 60.0 : 50.0;
        sections.add(PieChartSectionData(
          color: Colors.primaries[sectionIndex % Colors.primaries.length],
          value: usage,
          title: '$usage min',
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff)),
          badgeWidget: _Badge(app.icon, size: isTouched ? 40.0 : 30.0),
          badgePositionPercentageOffset: .98,
        ));
      }
    });

    setState(() {
      _sections = sections;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Screen Time')),
        body: Column(
          children: [
            Expanded(
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          _touchedIndex = -1;
                          return;
                        }
                        _touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 2,
                  centerSpaceRadius: 40,
                  sections: _sections,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _installedApps.length,
                itemBuilder: (context, index) {
                  ApplicationWithIcon app = _installedApps[index];
                  String screenTime = getScreenTime(app.packageName);

                  return ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(app.appName),
                          Text(
                            screenTime,
                            style:
                                TextStyle(fontSize: 12.0, color: Colors.grey),
                          ),
                        ],
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                      leading: Container(
                        width: 48.0,
                        child: app is ApplicationWithIcon
                            ? Image.memory(app.icon)
                            : Icon(Icons.error),
                      ),
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                AppDetailPage(packageName: app.packageName),
                          )));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final Uint8List icon;
  final double size;

  const _Badge(this.icon, {required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: MemoryImage(icon),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}*/

// screentime.dart
/*import 'dart:typed_data';
import 'package:app_usage/app_usage.dart';
import 'package:device_apps/device_apps.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/AppDetailPage.dart'; // Adjust the path as necessary
import 'package:flutter_application_1/screens/barchart.dart'; // Ensure this import points to the correct file path

void main() => runApp(screentime());

class screentime extends StatefulWidget {
  @override
  _screentimeState createState() => _screentimeState();
}

class _screentimeState extends State<screentime> {
  List<AppUsageInfo> _usageInfos = [];
  List<ApplicationWithIcon> _installedApps = [];
  List<PieChartSectionData> _sections = [];
  int _touchedIndex = -1;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await _loadInstalledApps();
    await _getUsageStats();
    _preparePieChartData();
  }

  Future<void> _loadInstalledApps() async {
    List<Application> apps = await DeviceApps.getInstalledApplications(
      onlyAppsWithLaunchIntent: true,
      includeAppIcons: true,
      includeSystemApps: true,
    );
    setState(() {
      _installedApps = apps.cast<ApplicationWithIcon>();
    });
  }

  Future<void> _getUsageStats() async {
    try {
      DateTime endDate = DateTime.now();
      DateTime startDate = DateTime(endDate.year, endDate.month, endDate.day)
          .subtract(Duration(days: 1));
      AppUsage appUsage = AppUsage();
      List<AppUsageInfo> infoList =
          await appUsage.getAppUsage(startDate, endDate);
      setState(() {
        _usageInfos = infoList;
      });
    } catch (exception) {
      print(exception);
    }
  }

  void _preparePieChartData() {
    final Map<String, double> usageMap = {};
    _usageInfos.forEach((info) {
      usageMap[info.packageName] = info.usage.inMinutes.toDouble();
    });

    List<PieChartSectionData> sections = [];
    _installedApps.forEach((app) {
      final appName = app.appName;
      final usage = usageMap[app.packageName] ?? 0.0;
      if (usage > 0) {
        final sectionIndex = sections.length;
        final isTouched = sectionIndex == _touchedIndex;
        final fontSize = isTouched ? 18.0 : 16.0;
        final radius = isTouched ? 60.0 : 50.0;
        sections.add(PieChartSectionData(
          color: Colors.primaries[sectionIndex % Colors.primaries.length],
          value: usage,
          title: '$usage min',
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff)),
          badgeWidget: _Badge(app.icon, size: isTouched ? 40.0 : 30.0),
          badgePositionPercentageOffset: .98,
        ));
      }
    });

    setState(() {
      _sections = sections;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Screen Time')),
        body: Column(
          children: [
            Expanded(
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          _touchedIndex = -1;
                          return;
                        }
                        _touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 2,
                  centerSpaceRadius: 40,
                  sections: _sections,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _installedApps.length,
                itemBuilder: (context, index) {
                  ApplicationWithIcon app = _installedApps[index];
                  String screenTime = getScreenTime(app.packageName);

                  return ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(app.appName),
                        Text(screenTime,
                            style:
                                TextStyle(fontSize: 12.0, color: Colors.grey)),
                      ],
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                    leading: Container(
                      width: 48.0,
                      child: app is ApplicationWithIcon
                          ? Image.memory(app.icon)
                          : Icon(Icons.error),
                    ),
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            AppDetailPage(packageName: app.packageName))),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getScreenTime(String packageName) {
    for (final info in _usageInfos) {
      if (info.packageName == packageName) {
        return formatDuration(info.usage);
      }
    }
    return "0h 0m 0s";
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitHours = twoDigits(duration.inHours.remainder(24));
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigitHours}h ${twoDigitMinutes}m ${twoDigitSeconds}s";
  }
}

class _Badge extends StatelessWidget {
  final Uint8List icon;
  final double size;

  const _Badge(this.icon, {required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: MemoryImage(icon),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}*/

import 'dart:typed_data';
import 'package:app_usage/app_usage.dart';
import 'package:device_apps/device_apps.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/screens/AppDetailPage.dart'; // Adjust the path as necessary
import 'package:flutter_application_1/screens/barchart.dart';
import 'package:flutter_application_1/screens/welcome.dart'; // Ensure this import points to the correct file path

void main() => runApp(screentime());

class screentime extends StatefulWidget {
  @override
  _screentimeState createState() => _screentimeState();
  static String id = 'dashboard_screen';
}

class _screentimeState extends State<screentime> {
  List<AppUsageInfo> _usageInfos = [];
  List<ApplicationWithIcon> _installedApps = [];
  List<PieChartSectionData> _sections = [];
  int _touchedIndex = -1;
  bool _showBarChart = false; // Flag to toggle between pie chart and bar chart

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await _loadInstalledApps();
    await _getUsageStats();
    _preparePieChartData();
  }

  Future<void> _loadInstalledApps() async {
    List<Application> apps = await DeviceApps.getInstalledApplications(
      onlyAppsWithLaunchIntent: true,
      includeAppIcons: true,
      includeSystemApps: true,
    );
    setState(() {
      _installedApps = apps.cast<ApplicationWithIcon>();
    });
  }

  Future<void> _getUsageStats() async {
    try {
      DateTime endDate = DateTime.now();
      DateTime startDate = DateTime(endDate.year, endDate.month, endDate.day)
          .subtract(Duration(days: 1));
      AppUsage appUsage = AppUsage();
      List<AppUsageInfo> infoList =
          await appUsage.getAppUsage(startDate, endDate);
      setState(() {
        _usageInfos = infoList;
      });
    } catch (exception) {
      print(exception);
    }
  }

  void _preparePieChartData() {
    final Map<String, double> usageMap = {};
    _usageInfos.forEach((info) {
      usageMap[info.packageName] = info.usage.inMinutes.toDouble();
    });

    List<PieChartSectionData> sections = [];
    _installedApps.forEach((app) {
      final appName = app.appName;
      final usage = usageMap[app.packageName] ?? 0.0;
      if (usage > 0) {
        final sectionIndex = sections.length;
        final isTouched = sectionIndex == _touchedIndex;
        final fontSize = isTouched ? 18.0 : 16.0;
        final radius = isTouched ? 80.0 : 90.0;
        sections.add(PieChartSectionData(
          color: Colors.primaries[sectionIndex % Colors.primaries.length],
          value: usage,
          title: '$usage min',
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff)),
          badgeWidget: _Badge(app.icon, size: isTouched ? 40.0 : 30.0),
          badgePositionPercentageOffset: .98,
        ));
      }
    });

    setState(() {
      _sections = sections;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('AppTrack Dashboard'),
          actions: [
            IconButton(
              icon: Icon(_showBarChart ? Icons.pie_chart : Icons.bar_chart),
              onPressed: () => setState(() {
                _showBarChart = !_showBarChart;
              }),
            ),
          ],
        ),
        drawer: NavDrawer(),
        body: _showBarChart
            ? BarChartScreen(
                usageInfos: _usageInfos) // Placeholder for your BarChartScreen
            : Column(
                children: [
                  Expanded(
                    child: PieChart(
                      PieChartData(
                        pieTouchData: PieTouchData(
                          touchCallback:
                              (FlTouchEvent event, pieTouchResponse) {
                            setState(() {
                              if (!event.isInterestedForInteractions ||
                                  pieTouchResponse == null ||
                                  pieTouchResponse.touchedSection == null) {
                                _touchedIndex = -1;
                                return;
                              }
                              _touchedIndex = pieTouchResponse
                                  .touchedSection!.touchedSectionIndex;
                            });
                          },
                        ),
                        borderData: FlBorderData(show: false),
                        sectionsSpace: 2,
                        centerSpaceRadius: 40,
                        sections: _sections,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _installedApps.length,
                      itemBuilder: (context, index) {
                        ApplicationWithIcon app = _installedApps[index];
                        String screenTime = getScreenTime(app.packageName);

                        return ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(app.appName),
                              Text(
                                screenTime,
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.black),
                              ),
                            ],
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16.0),
                          leading: Container(
                            width: 48.0,
                            child: app is ApplicationWithIcon
                                ? Image.memory(app.icon)
                                : Icon(Icons.error),
                          ),
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  AppDetailPage(packageName: app.packageName),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  String getScreenTime(String packageName) {
    for (final info in _usageInfos) {
      if (info.packageName == packageName) {
        return formatDuration(info.usage);
      }
    }
    return "0h 0m 0s";
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitHours = twoDigits(duration.inHours.remainder(24));
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigitHours}h ${twoDigitMinutes}m ${twoDigitSeconds}s";
  }
}

class _Badge extends StatelessWidget {
  final Uint8List icon;
  final double size;

  const _Badge(this.icon, {required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: MemoryImage(icon),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
