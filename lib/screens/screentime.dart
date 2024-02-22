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
