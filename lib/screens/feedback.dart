//import 'package:flutter/material.dart';
/*class FeedbackPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback'),
      ),
      body: Center(
        child: Text(
          'Feedback',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
*/

/*import 'package:flutter/material.dart';
import 'package:app_usage/app_usage.dart';

void main() => runApp(FeedbackPage());

class FeedbackPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Usage Example'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ScreenTimePage()),
            );
          },
          child: Text('View Screen Time'),
        ),
      ),
    );
  }
}

class ScreenTimePage extends StatefulWidget {
  @override
  _ScreenTimePageState createState() => _ScreenTimePageState();
}

class _ScreenTimePageState extends State<ScreenTimePage> {
  List<AppUsageInfo> _infos = [];

  @override
  void initState() {
    super.initState();
  }

  void getUsageStats() async {
    try {
      DateTime endDate = DateTime.now();
      DateTime startDate = endDate.subtract(Duration(hours: 1));
      List<AppUsageInfo> infoList =
          await AppUsage().getAppUsage(startDate, endDate);
      setState(() => _infos = infoList);

      for (var info in infoList) {
        print(info.toString());
      }
    } on AppUsageException catch (exception) {
      print(exception);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen Time'),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: _infos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_infos[index].appName),
            trailing: Text(_infos[index].usage.toString()),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getUsageStats,
        child: Icon(Icons.file_download),
      ),
    );
  }
}*/

/*import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';
import 'package:usage/usage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AppListScreen(),
    );
  }
}

class AppListScreen extends StatefulWidget {
  @override
  _AppListScreenState createState() => _AppListScreenState();
}

class _AppListScreenState extends State<AppListScreen> {
  List<ApplicationWithIcon> _apps = [];
  Map<String, double> _appUsage = {};

  @override
  void initState() {
    super.initState();
    _loadApps();
    _loadAppUsage();
  }

  Future<void> _loadApps() async {
    List<Application> apps = await DeviceApps.getInstalledApplications(
      onlyAppsWithLaunchIntent: true,
      includeSystemApps: true,
    );
    setState(() {
      _apps = apps.cast<ApplicationWithIcon>();
    });
  }

  Future<void> _loadAppUsage() async {

    Usage usage = Usage();
    DateTime endDate = DateTime.now();
    DateTime startDate = endDate.subtract(Duration(days: 7)); // Set the desired date range

    for (ApplicationWithIcon app in _apps) {
      double timeSpent = await usage.queryUsage(
        app.packageName,
        startDate,
        endDate,
      );
      setState(() {
        _appUsage[app.packageName] = timeSpent;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Usage Tracker'),
      ),
      body: ListView.builder(
        itemCount: _apps.length,
        itemBuilder: (context, index) {
          ApplicationWithIcon app = _apps[index];
          double timeSpent = _appUsage[app.packageName] ?? 0.0;

          return ListTile(
            leading: Image.memory(app.icon, width: 48, height: 48),
            title: Text(app.appName),
            subtitle: Text('Time Spent: ${timeSpent.toStringAsFixed(2)} seconds'),
          );
        },
      ),
    );
  }
}*/

/*import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';

void main() {
  runApp(FeedbackPage());
}

class FeedbackPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AppListPage(),
    );
  }
}

class AppListPage extends StatefulWidget {
  @override
  _AppListPageState createState() => _AppListPageState();
}

class _AppListPageState extends State<AppListPage> {
  List<ApplicationWithIcon> _installedApps = [];

  @override
  void initState() {
    super.initState();
    _loadInstalledApps();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Installed Apps'),
      ),
      body: ListView.builder(
        itemCount: _installedApps.length,
        itemBuilder: (context, index) {
          ApplicationWithIcon app = _installedApps[index];
          return ListTile(
            title: Text(app.appName),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.0), // Adjust as needed
            leading: Container(
              width: 48.0, // Adjust the width as needed
              child: app is ApplicationWithIcon
                  ? Image.memory(app.icon)
                  : Icon(Icons.error), // Placeholder for apps without icons
            ),
            // You can customize the ListTile as per your requirements
            // For example, you can add more details like package name, version, etc.
            // subtitle: Text('Package Name: ${app.packageName}'),
            // trailing: Text('Version: ${app.versionName}'),
          );
        },
      ),
    );
  }
}*/

/*import 'package:flutter/material.dart';
import 'package:app_usage/app_usage.dart';
import 'package:device_apps/device_apps.dart';

void main() => runApp(FeedbackPage());

class FeedbackPage extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<FeedbackPage> {
  List<AppUsageInfo> _usageInfos = [];
  List<ApplicationWithIcon> _installedApps = [];

  @override
  void initState() {
    super.initState();
    _loadInstalledApps();
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

  Future<void> getUsageStats(Application app) async {
    try {
      DateTime endDate = DateTime.now();
      DateTime startDate = endDate.subtract(Duration(hours: 1));
      List<AppUsageInfo> infoList = await AppUsage().getAppUsage(
        startDate,
        endDate,
      );
      setState(() {
        _usageInfos = infoList;
      });

      for (var info in infoList) {
        print(info.toString());
      }
    } on AppUsageException catch (exception) {
      print(exception);
    }
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
            String screenTime = _usageInfos.length > index
                ? '${_usageInfos[index].usage.inMinutes} minutes'
                : 'N/A';

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
              onTap: () => getUsageStats(app),
              trailing: Icon(Icons.arrow_forward),
            );
          },
        ),
      ),
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:app_usage/app_usage.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter_application_1/screens/AppDetailPage.dart';

void main() => runApp(FeedbackPage());

class FeedbackPage extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<FeedbackPage> {
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
}
