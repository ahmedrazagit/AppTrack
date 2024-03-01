/*import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';

void main() => runApp(const AppLock());

class AppLock extends StatelessWidget {
  const AppLock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Installed Apps with Time Limit',
      home: AppListPage(),
    );
  }
}

class AppListPage extends StatefulWidget {
  @override
  _AppListPageState createState() => _AppListPageState();
}

class _AppListPageState extends State<AppListPage> {
  List<Application> apps = [];

  @override
  void initState() {
    super.initState();
    _getInstalledApps();
  }

  Future<void> _getInstalledApps() async {
    List<Application> installedApps = await DeviceApps.getInstalledApplications(
      includeAppIcons: true,
      includeSystemApps: true,
      onlyAppsWithLaunchIntent: false,
    );
    setState(() {
      apps = installedApps;
    });
  }

  Future<void> _showSetTimeLimitDialog(Application app) async {
    TextEditingController timeLimitController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Set Time Limit for ${app.appName}'),
          content: TextField(
            controller: timeLimitController,
            decoration: const InputDecoration(hintText: "Enter time in hours"),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Set Limit'),
              onPressed: () {
                print(
                    "Time limit set for ${app.appName}: ${timeLimitController.text} hours");
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Installed Apps'),
      ),
      body: ListView.builder(
        itemCount: apps.length,
        itemBuilder: (context, index) {
          Application app = apps[index];
          return ListTile(
            leading: app is ApplicationWithIcon
                ? Image.memory(app.icon, width: 40, height: 40)
                : null,
            title: Text(app.appName),
            onTap: () => _showSetTimeLimitDialog(app),
          );
        },
      ),
    );
  }
}*/

/*import 'package:flutter/material.dart';
import 'package:app_usage/app_usage.dart';
import 'package:device_apps/device_apps.dart';
import 'package:collection/collection.dart';
import 'package:flutter_application_1/main.dart';

void main() => runApp(const applock());

class applock extends StatefulWidget {
  const applock({Key? key}) : super(key: key);

  @override
  _applockState createState() => _applockState();
}

class _applockState extends State<applock> {
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

  Future<void> _showSetTimeLimitDialog(ApplicationWithIcon app) async {
    TextEditingController timeLimitController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Set Time Limit for ${app.appName}'),
          content: TextField(
            controller: timeLimitController,
            decoration:
                const InputDecoration(hintText: "Enter time in minutes"),
            keyboardType: TextInputType.number,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Set Limit'),
              onPressed: () {
                final int? limit = int.tryParse(timeLimitController.text);
                if (limit != null) {
                  _checkUsageAndShowPopupIfNeeded(app.packageName, limit);
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _checkUsageAndShowPopupIfNeeded(
      String packageName, int limitInMinutes) async {
    try {
      DateTime endDate = DateTime.now();
      DateTime startDate = DateTime(endDate.year, endDate.month, endDate.day);
      AppUsage appUsage = AppUsage();
      List<AppUsageInfo> infoList =
          await appUsage.getAppUsage(startDate, endDate);
      final AppUsageInfo? usageInfo =
          infoList.firstWhereOrNull((info) => info.packageName == packageName);

      if (usageInfo != null && usageInfo.usage.inMinutes > limitInMinutes) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Time Limit Exceeded'),
              content: Text(
                  '${usageInfo.packageName} has exceeded its limit of $limitInMinutes minutes today.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print("Error checking app usage: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('App Usage Example'),
        ),
        body: ListView.builder(
          itemCount: _installedApps.length,
          itemBuilder: (context, index) {
            ApplicationWithIcon app = _installedApps[index];
            return ListTile(
              title: Text(app.appName),
              leading: Image.memory(app.icon),
              onTap: () => _showSetTimeLimitDialog(app),
            );
          },
        ),
      ),
    );
  }
}*/

/*import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_apps/flutter_overlay_apps.dart';
import 'package:app_usage/app_usage.dart';
import 'package:device_apps/device_apps.dart';
import 'dart:async';

void main() {
  runApp(const applock());
}

// overlay entry point
@pragma("vm:entry-point")
void showOverlay(String message) {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyOverlayContent(message: message)));
}

class applock extends StatelessWidget {
  const applock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Screentime(),
    );
  }
}

class Screentime extends StatefulWidget {
  const Screentime({Key? key}) : super(key: key);

  @override
  _ScreentimeState createState() => _ScreentimeState();
}

class _ScreentimeState extends State<Screentime> {
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
      includeSystemApps: false,
    );
    setState(() {
      _installedApps = apps.cast<ApplicationWithIcon>();
    });
  }

  Future<void> _showSetTimeLimitDialog(ApplicationWithIcon app) async {
    TextEditingController timeLimitController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Set Time Limit for ${app.appName}'),
          content: TextField(
            controller: timeLimitController,
            decoration:
                const InputDecoration(hintText: "Enter time in minutes"),
            keyboardType: TextInputType.number,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Set Limit'),
              onPressed: () async {
                final int? limit = int.tryParse(timeLimitController.text);
                if (limit != null) {
                  await _checkUsageAndTriggerOverlay(app.packageName, limit);
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _checkUsageAndTriggerOverlay(
      String packageName, int limitInMinutes) async {
    DateTime endDate = DateTime.now();
    DateTime startDate = DateTime(endDate.year, endDate.month, endDate.day);
    AppUsage appUsage = AppUsage();
    List<AppUsageInfo> infoList =
        await appUsage.getAppUsage(startDate, endDate);
    final AppUsageInfo? usageInfo =
        infoList.firstWhereOrNull((info) => info.packageName == packageName);

    if (usageInfo != null && usageInfo.usage.inMinutes > limitInMinutes) {
      // Show overlay if time limit exceeded
      showOverlay("Time limit exceeded for $packageName");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Usage Example'),
      ),
      body: ListView.builder(
        itemCount: _installedApps.length,
        itemBuilder: (context, index) {
          ApplicationWithIcon app = _installedApps[index];
          return ListTile(
            title: Text(app.appName),
            leading: Image.memory(app.icon),
            onTap: () => _showSetTimeLimitDialog(app),
          );
        },
      ),
    );
  }
}

class MyOverlayContent extends StatelessWidget {
  final String message;
  const MyOverlayContent({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          // Close overlay
          FlutterOverlayApps.closeOverlay();
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Close overlay
                  FlutterOverlayApps.closeOverlay();
                },
                child: const Text('Close'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/

/*import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_apps/flutter_overlay_apps.dart';
import 'package:app_usage/app_usage.dart';
import 'package:device_apps/device_apps.dart';
import 'dart:async';

void main() {
  runApp(const applock());
}

// overlay entry point
@pragma("vm:entry-point")
void showOverlay(String message) {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyOverlayContent(message: message)));
}

class applock extends StatelessWidget {
  const applock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Screentime(),
    );
  }
}

class Screentime extends StatefulWidget {
  const Screentime({Key? key}) : super(key: key);

  @override
  _ScreentimeState createState() => _ScreentimeState();
}

class _ScreentimeState extends State<Screentime> {
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
      includeSystemApps: false,
    );
    setState(() {
      _installedApps = apps.cast<ApplicationWithIcon>();
    });
  }

  Future<void> _showSetTimeLimitDialog(ApplicationWithIcon app) async {
    TextEditingController timeLimitController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Set Time Limit for ${app.appName}'),
          content: TextField(
            controller: timeLimitController,
            decoration:
                const InputDecoration(hintText: "Enter time in minutes"),
            keyboardType: TextInputType.number,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Set Limit'),
              onPressed: () async {
                final int? limit = int.tryParse(timeLimitController.text);
                if (limit != null) {
                  await _checkUsageAndTriggerOverlay(app.packageName, limit);
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _checkUsageAndTriggerOverlay(
      String packageName, int limitInMinutes) async {
    DateTime endDate = DateTime.now();
    DateTime startDate = DateTime(endDate.year, endDate.month, endDate.day);
    AppUsage appUsage = AppUsage();
    List<AppUsageInfo> infoList =
        await appUsage.getAppUsage(startDate, endDate);
    final AppUsageInfo? usageInfo =
        infoList.firstWhereOrNull((info) => info.packageName == packageName);

    if (usageInfo != null && usageInfo.usage.inMinutes > limitInMinutes) {
      // Show overlay if time limit exceeded
      showOverlay("Time limit exceeded for $packageName");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Usage Example'),
      ),
      body: ListView.builder(
        itemCount: _installedApps.length,
        itemBuilder: (context, index) {
          ApplicationWithIcon app = _installedApps[index];
          return ListTile(
            title: Text(app.appName),
            leading: Image.memory(app.icon),
            onTap: () => _showSetTimeLimitDialog(app),
          );
        },
      ),
    );
  }
}

class MyOverlayContent extends StatelessWidget {
  final String message;
  const MyOverlayContent({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          // Close overlay
          FlutterOverlayApps.closeOverlay();
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Close overlay
                  FlutterOverlayApps.closeOverlay();
                },
                child: const Text('Close'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/

/*import 'package:flutter/material.dart';
import 'package:app_usage/app_usage.dart';
import 'package:device_apps/device_apps.dart';
import 'package:collection/collection.dart';
import 'package:flutter_overlay_apps/flutter_overlay_apps.dart';

void main() => runApp(const Applocks());

class Applocks extends StatefulWidget {
  const Applocks({Key? key}) : super(key: key);

  @override
  _ApplocksState createState() => _ApplocksState();
}

class _ApplocksState extends State<Applocks> {
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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('App Usage Example'),
        ),
        body: ListView.builder(
          itemCount: _installedApps.length,
          itemBuilder: (context, index) {
            ApplicationWithIcon app = _installedApps[index];
            return AppLockTile(app: app);
          },
        ),
      ),
    );
  }
}

class AppLockTile extends StatelessWidget {
  final ApplicationWithIcon app;

  const AppLockTile({Key? key, required this.app}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(app.appName),
      leading: Image.memory(app.icon),
      onTap: () {
        _showSetTimeLimitDialog(context, app);
      },
    );
  }

  void _showSetTimeLimitDialog(BuildContext context, ApplicationWithIcon app) {
    TextEditingController timeLimitController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Set Time Limit for ${app.appName}'),
          content: TextField(
            controller: timeLimitController,
            decoration:
                const InputDecoration(hintText: "Enter time in minutes"),
            keyboardType: TextInputType.number,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Set Limit'),
              onPressed: () {
                final int? limit = int.tryParse(timeLimitController.text);
                if (limit != null) {
                  _checkUsageAndShowOverlayIfNeeded(app.packageName, limit);
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _checkUsageAndShowOverlayIfNeeded(
      String packageName, int limitInMinutes) async {
    try {
      DateTime endDate = DateTime.now();
      DateTime startDate = DateTime(endDate.year, endDate.month, endDate.day);
      AppUsage appUsage = AppUsage();
      List<AppUsageInfo> infoList =
          await appUsage.getAppUsage(startDate, endDate);
      final AppUsageInfo? usageInfo =
          infoList.firstWhereOrNull((info) => info.packageName == packageName);

      if (usageInfo != null && usageInfo.usage.inMinutes > limitInMinutes) {
        _showOverlay();
      }
    } catch (e) {
      print("Error checking app usage: $e");
    }
  }

  void _showOverlay() {
    FlutterOverlayApps.showOverlay(
        height: 300, width: 400, alignment: OverlayAlignment.center);
  }
}*/

/*import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:app_usage/app_usage.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter_overlay_apps/flutter_overlay_apps.dart';

void main() => runApp(const Applocks());

// overlay entry point
@pragma("vm:entry-point")
void showOverlay() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Material(child: Text("Time Limit Reached")),
  ));
}

class Applocks extends StatefulWidget {
  const Applocks({Key? key}) : super(key: key);

  @override
  _ApplocksState createState() => _ApplocksState();
}

class _ApplocksState extends State<Applocks> {
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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('App Usage Example'),
        ),
        body: ListView.builder(
          itemCount: _installedApps.length,
          itemBuilder: (context, index) {
            ApplicationWithIcon app = _installedApps[index];
            return AppLockTile(app: app);
          },
        ),
      ),
    );
  }
}

class AppLockTile extends StatelessWidget {
  final ApplicationWithIcon app;

  const AppLockTile({Key? key, required this.app}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(app.appName),
      leading: Image.memory(app.icon),
      onTap: () {
        _showSetTimeLimitDialog(context, app);
      },
    );
  }

  void _showSetTimeLimitDialog(BuildContext context, ApplicationWithIcon app) {
    TextEditingController timeLimitController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Set Time Limit for ${app.appName}'),
          content: TextField(
            controller: timeLimitController,
            decoration:
                const InputDecoration(hintText: "Enter time in minutes"),
            keyboardType: TextInputType.number,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Set Limit'),
              onPressed: () {
                final int? limit = int.tryParse(timeLimitController.text);
                if (limit != null) {
                  Navigator.of(context).pop();
                  _checkUsageAndShowOverlayIfNeeded(
                      context, app.packageName, limit);
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _checkUsageAndShowOverlayIfNeeded(
      BuildContext context, String packageName, int limitInMinutes) async {
    try {
      DateTime endDate = DateTime.now();
      DateTime startDate = DateTime(endDate.year, endDate.month, endDate.day);
      AppUsage appUsage = AppUsage();
      List<AppUsageInfo> infoList =
          await appUsage.getAppUsage(startDate, endDate);
      final AppUsageInfo? usageInfo =
          infoList.firstWhereOrNull((info) => info.packageName == packageName);

      if (usageInfo != null && usageInfo.usage.inMinutes > limitInMinutes) {
        FlutterOverlayApps.showOverlay(
          height: 300,
          width: 400,
          alignment: OverlayAlignment.center,
        );
      }
    } catch (e) {
      print("Error checking app usage: $e");
    }
  }
}*/

/*import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter_overlay_apps/flutter_overlay_apps.dart';

void main() => runApp(const Applocks());

// overlay entry point
@pragma("vm:entry-point")
void showOverlay() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Material(
        child: Center(
            child: Text(
      "Time Limit Reached for YouTube",
      textAlign: TextAlign.center,
    ))),
  ));
}

class Applocks extends StatefulWidget {
  const Applocks({Key? key}) : super(key: key);

  @override
  _ApplocksState createState() => _ApplocksState();
}

class _ApplocksState extends State<Applocks> {
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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('App Usage Example'),
        ),
        body: ListView.builder(
          itemCount: _installedApps.length,
          itemBuilder: (context, index) {
            ApplicationWithIcon app = _installedApps[index];
            return AppLockTile(app: app);
          },
        ),
      ),
    );
  }
}

class AppLockTile extends StatelessWidget {
  final ApplicationWithIcon app;

  const AppLockTile({Key? key, required this.app}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(app.appName),
      leading: Image.memory(app.icon),
      onTap: () {
        // Directly show the overlay for YouTube for testing
        if (app.packageName
            .toLowerCase()
            .contains("com.google.android.youtube")) {
          _showOverlay();
        }
      },
    );
  }

  void _showOverlay() {
    FlutterOverlayApps.showOverlay(
      height: 300,
      width: 400,
      alignment: OverlayAlignment.center,
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:usage_stats/usage_stats.dart';
import 'package:flutter_application_1/applock/database/database_service.dart';
import 'package:flutter_application_1/applock/main_app_ui/home.dart';
import 'package:flutter_application_1/applock/main_app_ui/permissions_screen.dart';
import 'package:flutter_application_1/applock/monitoring_service/utils/flutter_background_service_utils.dart';

class AppLocks extends StatefulWidget {
  static const String id = 'app_lock_page'; // For navigation purposes

  @override
  _AppLocksState createState() => _AppLocksState();
}

class _AppLocksState extends State<AppLocks> {
  late Widget _screenToDisplay;
  bool _isLoading = true; // To handle loading state

  @override
  void initState() {
    super.initState();
    _checkPermissionsAndInitialize();
  }

  Future<void> _checkPermissionsAndInitialize() async {
    // Ensure WidgetsFlutterBinding is initialized
    WidgetsFlutterBinding.ensureInitialized();

    // Start the monitoring service, if needed
    await startMonitoringService();

    // Instantiate the DatabaseService
    DatabaseService dbService = await DatabaseService.instance();

    // Check for necessary permissions
    bool permissionsAvailable = (await UsageStats.checkUsagePermission())! &&
        await FlutterOverlayWindow.isPermissionGranted();

    // Decide which screen to display based on permissions
    Widget screen =
        permissionsAvailable ? Home(dbService) : PermissionsScreen(dbService);

    // Update state to display the chosen screen
    setState(() {
      _screenToDisplay = screen;
      _isLoading = false; // Loading is complete
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
              child:
                  CircularProgressIndicator()) // Show loading indicator while checking permissions
          : _screenToDisplay, // Once loading is complete, show the selected screen
    );
  }
}
