/*import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:flutter_application_1/screens/signup.dart';
import 'package:flutter_application_1/screens/welcome.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
          apiKey: "AIzaSyDGB28gjsO7DXVgO7BZHDNmhgkozzy4Dtc",
          appId: "1:448240816942:android:a34e1dbc4ba3a4d30460bf",
          messagingSenderId: "448240816942",
          projectId: "uni-project-ce850",
        ))
      : await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme: const TextTheme(
        bodyMedium: TextStyle(
          fontFamily: 'Ubuntu',
        ),
      )),
      initialRoute: HomeScreen.id,
      routes: {
        HomeScreen.id: (context) => const HomeScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        SignUpScreen.id: (context) => const SignUpScreen(),
        WelcomeScreen.id: (context) => const WelcomeScreen(),
      },
    );
  }
}*/

/*import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:flutter_application_1/applock/alert_dialog_service/overlay_widget.dart';
import 'package:flutter_application_1/applock/database/database_service.dart';
import 'package:flutter_application_1/applock/main_app_ui/home.dart';
import 'package:flutter_application_1/applock/main_app_ui/permissions_screen.dart';
import 'package:flutter_application_1/applock/monitoring_service/utils/flutter_background_service_utils.dart';
import 'package:usage_stats/usage_stats.dart';

void main() async {
  // Start the monitoring service
  await onStart();
  DatabaseService dbService = await DatabaseService.instance();
  bool permissionsAvailable = (await UsageStats.checkUsagePermission())! &&
      await FlutterOverlayWindow.isPermissionGranted();
  runApp(MyApp(
      permissionsAvailable ? Home(dbService) : PermissionsScreen(dbService),
      dbService));
}

onStart() async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  await startMonitoringService();
}

// This is the isolate entry for the Alert Window Service
// It needs to be added in the main.dart file with the name "overlayMain"...(jugaadu code max by plugin dev)
@pragma("vm:entry-point")
void overlayMain() async {
  debugPrint("Starting Alerting Window Isolate!");
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: OverlayWidget()));
}

class MyApp extends StatelessWidget {
  Widget screenToDisplay;

  DatabaseService dbService;

  MyApp(this.screenToDisplay, this.dbService);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: screenToDisplay,
    );
  }
}*/

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/applock/alert_dialog_service/overlay_widget.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:flutter_application_1/screens/screentime.dart';
import 'package:flutter_application_1/screens/signup.dart'; // Ensure correct file name
import 'package:flutter_application_1/screens/welcome.dart'; // Ensure correct file name
import 'package:flutter_application_1/screens/screentime.dart'; // Ensure correct file name

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDGB28gjsO7DXVgO7BZHDNmhgkozzy4Dtc",
        appId: "1:448240816942:android:a34e1dbc4ba3a4d30460bf",
        messagingSenderId: "448240816942",
        projectId: "uni-project-ce850",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontFamily: 'Ubuntu'),
        ),
      ),
      //initialRoute: HomeScreen.id,
      initialRoute: screentime.id, // Set initial route to WelcomeScreen
      routes: {
        HomeScreen.id: (context) => const HomeScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        SignUpScreen.id: (context) => const SignUpScreen(),
        //WelcomeScreen.id: (context) => const WelcomeScreen(),
        screentime.id: (context) => screentime(),
        // Add route for AppLockPage once created
      },
    );
  }
}

@pragma('vm:entry-point')
void overlayMain() async {
  debugPrint("Starting Alerting Window Isolate!");
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: OverlayWidget()));
}
