/*import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_application_1/applock/alert_dialog_service/alert_dialog_service.dart';
import 'package:flutter_application_1/applock/database/database_service.dart';
import 'package:flutter_application_1/applock/dtos/application_data.dart';
import 'package:flutter_application_1/applock/monitoring_service/utils/user_usage_utils.dart';
import 'package:usage_stats/usage_stats.dart';

const String STOP_MONITORING_SERVICE_KEY = "stop";
const String SET_APPS_NAME_FOR_MONITORING_KEY = "setAppsNames";
const String APP_NAMES_LIST_KEY = "appNames";

// Entry Point for Monitoring Isolate
@pragma('vm:entry-point')
onMonitoringServiceStart(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseService databaseService = await DatabaseService.instance();

  Map<String, ApplicationData> monitoredApplicationSet = {};

  // Stop this background service
  _registerListener(service);

  Map<String, UsageInfo> previousUsageSession =
      await getCurrentUsageStats(monitoredApplicationSet);
  _startTimer(databaseService, monitoredApplicationSet, previousUsageSession);
}

Future<void> _startTimer(
    DatabaseService databaseService,
    Map<String, ApplicationData> monitoredApplicationSet,
    Map<String, UsageInfo> previousUsageSession) async {
  Timer.periodic(const Duration(seconds: 1), (timer) async {
    timer.cancel();
    _setMonitoringApplicationsSet(databaseService, monitoredApplicationSet);
    Map<String, UsageInfo> currentUsageSession =
        await getCurrentUsageStats(monitoredApplicationSet);
    String? appOpened = checkIfAnyAppHasBeenOpened(
        currentUsageSession, previousUsageSession, monitoredApplicationSet);
    if (appOpened != null) {
      AlertDialogService.createAlertDialog();
    }
    previousUsageSession = currentUsageSession;

    _startTimer(databaseService, monitoredApplicationSet, previousUsageSession);
  });
}

_setMonitoringApplicationsSet(DatabaseService databaseService,
    Map<String, ApplicationData> monitoredApplicationSet) {
  List<ApplicationData> monitoredApps = databaseService.getAllAppData();
  monitoredApplicationSet.clear();

  for (ApplicationData app in monitoredApps) {
    monitoredApplicationSet[app.appId] = app;
  }
}

_registerListener(ServiceInstance service) {
  service.on(STOP_MONITORING_SERVICE_KEY).listen((event) {
    service.stopSelf();
  });
}*/

/*import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_application_1/applock/alert_dialog_service/alert_dialog_service.dart';
import 'package:flutter_application_1/applock/database/database_service.dart';
import 'package:flutter_application_1/applock/dtos/application_data.dart';
import 'package:usage_stats/usage_stats.dart';

const String STOP_MONITORING_SERVICE_KEY = "stop";
const String SET_APPS_NAME_FOR_MONITORING_KEY = "setAppsNames";
const String APP_NAMES_LIST_KEY = "appNames";

@pragma('vm:entry-point')
void onMonitoringServiceStart(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseService databaseService = await DatabaseService.instance();

  Map<String, ApplicationData> monitoredApplicationSet = {};

  _registerListener(service);

  // Start the timer for continuous monitoring
  _startMonitoring(databaseService, monitoredApplicationSet);
}

Future<void> _startMonitoring(DatabaseService databaseService,
    Map<String, ApplicationData> monitoredApplicationSet) async {
  Timer.periodic(const Duration(minutes: 1), (timer) async {
    await getUsage(databaseService, monitoredApplicationSet);
  });
}

Future<void> getUsage(DatabaseService databaseService,
    Map<String, ApplicationData> monitoredApplicationSet) async {
  DateTime endDate = DateTime.now();
  DateTime startDate =
      DateTime(endDate.year, endDate.month, endDate.day, 0, 0, 0);

  // Query aggregated usage statistics
  Map<String, UsageInfo> usageStats =
      await UsageStats.queryAndAggregateUsageStats(startDate, endDate);

  for (String appId in monitoredApplicationSet.keys) {
    if (usageStats.containsKey(appId)) {
      final int usageLimit = await databaseService.getAppUsageLimit(appId);
      final UsageInfo? currentUsageInfo = usageStats[appId];

      if (currentUsageInfo != null) {
        final int totalScreenTimeToday =
            ((currentUsageInfo.totalTimeInForeground as int) / 60000.round())
                as int;
        if (totalScreenTimeToday > usageLimit) {
          AlertDialogService
              .createAlertDialog(); // Customize this for your needs
        }
      }
    }
  }
}

void _registerListener(ServiceInstance service) {
  service.on(STOP_MONITORING_SERVICE_KEY).listen((event) {
    service.stopSelf();
  });
}

Future<void> _setMonitoringApplicationsSet(DatabaseService databaseService,
    Map<String, ApplicationData> monitoredApplicationSet) async {
  List<ApplicationData> monitoredApps = await databaseService.getAllAppData();
  monitoredApplicationSet.clear();

  for (ApplicationData app in monitoredApps) {
    monitoredApplicationSet[app.appId] = app;
  }
}
*/
/*import 'dart:async';
import 'package:flutter/material.dart';
import 'package:app_usage/app_usage.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_application_1/applock/alert_dialog_service/alert_dialog_service.dart';
import 'package:flutter_application_1/applock/database/database_service.dart';
import 'package:flutter_application_1/applock/dtos/application_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MonitoringPage(),
    );
  }
}

class MonitoringPage extends StatefulWidget {
  @override
  _MonitoringPageState createState() => _MonitoringPageState();
}

class _MonitoringPageState extends State<MonitoringPage> {
  @override
  void initState() {
    super.initState();
    onMonitoringServiceStart();
  }

  void onMonitoringServiceStart() async {
    WidgetsFlutterBinding.ensureInitialized();
    DatabaseService databaseService = await DatabaseService.instance();

    Map<String, ApplicationData> monitoredApplicationSet = {};

    // Start the timer for continuous monitoring
    _startMonitoring(databaseService, monitoredApplicationSet);
  }

  Future<void> _startMonitoring(DatabaseService databaseService, Map<String, ApplicationData> monitoredApplicationSet) async {
    Timer.periodic(const Duration(minutes: 1), (timer) async {
      await getUsage(databaseService, monitoredApplicationSet);
    });
  }

  Future<void> getUsage(DatabaseService databaseService, Map<String, ApplicationData> monitoredApplicationSet) async {
    DateTime endDate = DateTime.now();
    DateTime startDate = endDate.subtract(const Duration(days: 1));

    try {
      AppUsage appUsage = AppUsage();
      List<AppUsageInfo> infoList = await appUsage.getAppUsage(startDate, endDate);
      Map<String, AppUsageInfo> usageStats = {for (var info in infoList) info.packageName: info};

      for (String appId in monitoredApplicationSet.keys) {
        if (usageStats.containsKey(appId)) {
          final AppUsageInfo currentUsageInfo = usageStats[appId]!;
          final int usageLimit = await databaseService.getAppUsageLimit(appId);
          final int totalScreenTimeToday = (currentUsageInfo.usage.inSeconds / 60).round();

          if (totalScreenTimeToday > usageLimit) {
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              AlertDialogService.createAlertDialog(); // Make sure this fits your implementation
            });
          }
        }
      }
    } catch (exception) {
      print("Error fetching app usage: $exception");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Monitoring Service"),
      ),
      body: Center(
        child: Text("Monitoring App Usage"),
      ),
    );
  }
}*/

/*import 'dart:async';
import 'package:flutter/material.dart';
import 'package:app_usage/app_usage.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_application_1/applock/alert_dialog_service/alert_dialog_service.dart'; // Update with your actual import path
import 'package:flutter_application_1/applock/database/database_service.dart'; // Update with your actual import path
import 'package:flutter_application_1/applock/dtos/application_data.dart'; // Update with your actual import path
import 'package:usage_stats/usage_stats.dart'; // This might be hypothetical as per your setup

const String STOP_MONITORING_SERVICE_KEY = "stop";
const String SET_APPS_NAME_FOR_MONITORING_KEY = "setAppsNames";
const String APP_NAMES_LIST_KEY = "appNames";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MonitoringPage(),
    );
  }
}

class MonitoringPage extends StatefulWidget {
  @override
  _MonitoringPageState createState() => _MonitoringPageState();
}

class _MonitoringPageState extends State<MonitoringPage> {
  @override
  void initState() {
    super.initState();
    onMonitoringServiceStart;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App Usage Monitoring"),
      ),
      body: Center(
        child: Text("Monitoring Service Running"),
      ),
    );
  }
}

@pragma('vm:entry-point')
void onMonitoringServiceStart(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseService databaseService = await DatabaseService.instance();

  Map<String, ApplicationData> monitoredApplicationSet = {};

  // Assume these functions are defined within the scope
  _registerListener(service);
  Map<String, UsageInfo> previousUsageSession =
      await getCurrentUsageStats(monitoredApplicationSet);
  _startTimer(databaseService, monitoredApplicationSet, previousUsageSession);
}

Future<Map<String, UsageInfo>> getCurrentUsageStats(
    Map<String, ApplicationData> appIds) async {
  // Mock implementation. Replace with actual logic to fetch usage stats.
  return {};
}

Future<void> _startTimer(
    DatabaseService databaseService,
    Map<String, ApplicationData> monitoredApplicationSet,
    Map<String, UsageInfo> previousUsageSession) async {
  Timer.periodic(const Duration(minutes: 1), (timer) async {
    // Ensure monitoring applications set is up-to-date
    await _setMonitoringApplicationsSet(
        databaseService, monitoredApplicationSet);

    // Here, integrate AppUsage as shown in previous examples
    DateTime now = DateTime.now();
    DateTime startOfDay = DateTime(now.year, now.month, now.day);
    AppUsage appUsage = AppUsage();
    List<AppUsageInfo> appUsageInfos =
        await appUsage.getAppUsage(startOfDay, now);

    Map<String, double> appUsageMinutes = {
      for (var info in appUsageInfos)
        info.packageName: info.usage.inMinutes.toDouble()
    };

    for (String appId in monitoredApplicationSet.keys) {
      final double usageMinutes = appUsageMinutes[appId] ?? 0.0;
      final int usageLimit = await databaseService.getAppUsageLimit(appId);

      if (usageMinutes > usageLimit) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          AlertDialogService
              .createAlertDialog(); // Make sure this is correctly set up
        });
      }
    }

    // Logic to update previousUsageSession if necessary
  });
}

Future<void> _setMonitoringApplicationsSet(DatabaseService databaseService,
    Map<String, ApplicationData> monitoredApplicationSet) async {
  List<ApplicationData> monitoredApps = await databaseService.getAllAppData();
  monitoredApplicationSet.clear();
  for (ApplicationData app in monitoredApps) {
    monitoredApplicationSet[app.appId] = app;
  }
}

void _registerListener(ServiceInstance service) {
  service.on(STOP_MONITORING_SERVICE_KEY).listen((event) {
    service.stopSelf();
  });
}*/

/*import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_application_1/applock/alert_dialog_service/alert_dialog_service.dart';
import 'package:flutter_application_1/applock/database/database_service.dart';
import 'package:flutter_application_1/applock/dtos/application_data.dart';
import 'package:flutter_application_1/applock/monitoring_service/utils/user_usage_utils.dart';
import 'package:usage_stats/usage_stats.dart';
import 'package:app_usage/app_usage.dart';

const String STOP_MONITORING_SERVICE_KEY = "stop";
const String SET_APPS_NAME_FOR_MONITORING_KEY = "setAppsNames";
const String APP_NAMES_LIST_KEY = "appNames";

// Entry Point for Monitoring Isolate
@pragma('vm:entry-point')
onMonitoringServiceStart(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseService databaseService = await DatabaseService.instance();

  Map<String, ApplicationData> monitoredApplicationSet = {};

  // Stop this background service
  _registerListener(service);

  Map<String, UsageInfo> previousUsageSession =
      await getCurrentUsageStats(monitoredApplicationSet);
  _startTimer(databaseService, monitoredApplicationSet, previousUsageSession);
}

Future<void> _startTimer(
    DatabaseService databaseService,
    Map<String, ApplicationData> monitoredApplicationSet,
    Map<String, UsageInfo> previousUsageSession) async {
  Timer.periodic(const Duration(seconds: 1), (timer) async {
    timer.cancel();
    _setMonitoringApplicationsSet(databaseService, monitoredApplicationSet);
    Map<String, UsageInfo> currentUsageSession =
        await getCurrentUsageStats(monitoredApplicationSet);
    String? appOpened = checkIfAnyAppHasBeenOpened(
        currentUsageSession, previousUsageSession, monitoredApplicationSet);
    if (appOpened != null) {
      final UsageInfo? openedAppUsageInfo = currentUsageSession[appOpened];
      if (openedAppUsageInfo != null) {
        // Assuming totalTimeInForeground is in milliseconds, convert to minutes
        final double usageMinutes =
            double.parse(openedAppUsageInfo.totalTimeInForeground!) / 60000.0;
        final int usageLimit =
            await databaseService.getAppUsageLimit(appOpened);
        if (usageMinutes > usageLimit) {
          AlertDialogService.createAlertDialog();
        }
      }
      previousUsageSession = currentUsageSession;

      _startTimer(
          databaseService, monitoredApplicationSet, previousUsageSession);
    }
  });
}

_setMonitoringApplicationsSet(DatabaseService databaseService,
    Map<String, ApplicationData> monitoredApplicationSet) {
  List<ApplicationData> monitoredApps = databaseService.getAllAppData();
  monitoredApplicationSet.clear();

  for (ApplicationData app in monitoredApps) {
    monitoredApplicationSet[app.appId] = app;
  }
}

_registerListener(ServiceInstance service) {
  service.on(STOP_MONITORING_SERVICE_KEY).listen((event) {
    service.stopSelf();
  });
}*/

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:app_usage/app_usage.dart';
import 'package:flutter_application_1/applock/alert_dialog_service/alert_dialog_service.dart'; // Adjust the import path based on your project structure
import 'package:flutter_application_1/applock/database/database_service.dart'; // Adjust the import path based on your project structure
import 'package:flutter_application_1/applock/dtos/application_data.dart'; // Adjust the import path based on your project structure
import 'package:flutter_application_1/applock/monitoring_service/utils/user_usage_utils.dart';
import 'package:usage_stats/usage_stats.dart'; // If applicable

const String STOP_MONITORING_SERVICE_KEY = "stop";
const String SET_APPS_NAME_FOR_MONITORING_KEY = "setAppsNames";
const String APP_NAMES_LIST_KEY = "appNames";

@pragma('vm:entry-point')
onMonitoringServiceStart(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseService databaseService = await DatabaseService.instance();

  Map<String, ApplicationData> monitoredApplicationSet = {};

  // Stop this background service
  _registerListener(service);

  Map<String, UsageInfo> previousUsageSession =
      await getCurrentUsageStats(monitoredApplicationSet);
  _startTimer(databaseService, monitoredApplicationSet, previousUsageSession);
}

Future<void> _startTimer(
    DatabaseService databaseService,
    Map<String, ApplicationData> monitoredApplicationSet,
    Map<String, UsageInfo> previousUsageSession) async {
  Timer.periodic(const Duration(seconds: 1), (timer) async {
    timer.cancel();
    _setMonitoringApplicationsSet(databaseService, monitoredApplicationSet);
    Map<String, UsageInfo> currentUsageSession =
        await getCurrentUsageStats(monitoredApplicationSet);
    String? appOpened = checkIfAnyAppHasBeenOpened(
        currentUsageSession, previousUsageSession, monitoredApplicationSet);
    if (appOpened != null) {
      await _checkAndHandleAppUsage(databaseService, appOpened);
      //AlertDialogService.createAlertDialog();
    }

    previousUsageSession = currentUsageSession;
    _startTimer(databaseService, monitoredApplicationSet, previousUsageSession);
  });
}

Future<void> _setMonitoringApplicationsSet(DatabaseService databaseService,
    Map<String, ApplicationData> monitoredApplicationSet) async {
  List<ApplicationData> monitoredApps = await databaseService.getAllAppData();
  monitoredApplicationSet.clear();

  for (ApplicationData app in monitoredApps) {
    monitoredApplicationSet[app.appId] = app;
  }
}

void _registerListener(ServiceInstance service) {
  service.on(STOP_MONITORING_SERVICE_KEY).listen((event) {
    service.stopSelf();
  });
}

Future<void> _checkAndHandleAppUsage(
    DatabaseService databaseService, String appOpened) async {
  DateTime now = DateTime.now();
  DateTime startOfDay = DateTime(now.year, now.month, now.day);

  try {
    AppUsage appUsage = AppUsage();
    List<AppUsageInfo> infoList = await appUsage.getAppUsage(startOfDay, now);
    Map<String, double> appUsageMinutes = {
      for (var info in infoList)
        info.packageName: info.usage.inMinutes.toDouble()
    };

    final double usageMinutes = appUsageMinutes[appOpened] ?? 0.0;
    final int usageLimit = await databaseService.getAppUsageLimit(appOpened);

    if (usageMinutes > usageLimit) {
      AlertDialogService
          .createAlertDialog(); // Implement this method to update UI on the main thread
    }
  } catch (e) {
    print("Error fetching app usage: $e");
  }
}
