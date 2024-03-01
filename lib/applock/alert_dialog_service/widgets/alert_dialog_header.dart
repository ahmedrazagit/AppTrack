/*import 'package:flutter_application_1/applock/alert_dialog_service/alert_dialog_service.dart';
import 'package:flutter_application_1/applock/main_app_ui/utils/fonts.dart';
import 'package:flutter/material.dart';

class AlertDialogHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Material(
      type: MaterialType.transparency,
      child: SizedBox(
        height: screenHeight, // Use the full screen height
        width: screenWidth, // Use the full screen width
        child: Column(
          children: [
            Spacer(),
            _title(),
            Spacer(),
            _dismissButton(context),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    // Update the text to "Time is Up"
    return Text("Time is Up", style: Fonts.header3(color: Colors.white));
  }

  Widget _dismissButton(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return IconButton(
      color: Colors.white,
      onPressed: () async {
        await AlertDialogService.closeAlertDialog();
      },
      icon: Icon(
        Icons.close,
        size: screenHeight * 0.04,
      ),
    );
  }
}*/

/*import 'package:flutter/material.dart';
import 'package:alert_dialog_service/alert_dialog_service.dart';
import 'package:main_app_ui/utils/fonts.dart';
import 'package:device_apps/device_apps.dart';
import 'package:url_launcher/url_launcher.dart';

class AlertDialogHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Material(
      type: MaterialType.transparency,
      child: SizedBox(
        height: screenHeight, // Use the full screen height
        width: screenWidth, // Use the full screen width
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Time is Up", style: Fonts.header3(color: Colors.white)),
            SizedBox(height: 20), // Adds some spacing
            Expanded(
              child: _buildAppList(context),
            ),
            _dismissButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildAppList(BuildContext context) {
    return FutureBuilder(
      future: DeviceApps.getInstalledApplications(
        includeAppIcons: true,
        includeSystemApps: false,
        onlyAppsWithLaunchIntent: true,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          List<Application> apps = snapshot.data as List<Application>;
          return ListView.builder(
            itemCount: apps.length,
            itemBuilder: (context, index) {
              Application app = apps[index];
              return ListTile(
                leading:
                    app is ApplicationWithIcon ? Image.memory(app.icon) : null,
                title: Text(app.appName),
                onTap: () => DeviceApps.openApp(app.packageName),
              );
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _dismissButton(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return IconButton(
      color: Colors.white,
      onPressed: () async {
        await AlertDialogService.closeAlertDialog();
      },
      icon: Icon(
        Icons.close,
        size: screenHeight * 0.04,
      ),
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:flutter_application_1/applock/alert_dialog_service/alert_dialog_service.dart';
import 'package:flutter_application_1/applock/main_app_ui/utils/fonts.dart';
import 'package:device_apps/device_apps.dart';

class AlertDialogHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Material(
      type: MaterialType.transparency,
      child: Center(
        // Center the box in the middle of the screen
        child: Container(
          width: screenWidth * 0.8, // Adjust the width as needed
          height: screenHeight * 0.6, // Adjust the height as needed
          decoration: BoxDecoration(
            color: Colors.white, // White background for the box
            borderRadius: BorderRadius.circular(20), // Rounded corners
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Time is Up",
                    style: Fonts.header3(
                        color:
                            Colors.black)), // Adjust text color for visibility
              ),
              SizedBox(height: 10), // Adjust spacing
              Expanded(
                child: _buildAppList(context),
              ),
              _dismissButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppList(BuildContext context) {
    return FutureBuilder(
      future: DeviceApps.getInstalledApplications(
        includeAppIcons: true,
        includeSystemApps: true, // Changed to true to include system apps
        onlyAppsWithLaunchIntent: true,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          List<Application> apps = snapshot.data as List<Application>;
          return ListView.builder(
            itemCount: apps.length,
            itemBuilder: (context, index) {
              Application app = apps[index];
              return ListTile(
                leading: app is ApplicationWithIcon
                    ? Container(
                        padding: EdgeInsets.all(3), // Adjust padding
                        child: Image.memory(app.icon, fit: BoxFit.cover),
                      )
                    : null,
                title: Text(app.appName,
                    style: TextStyle(
                        color:
                            Colors.black)), // Adjust text color for visibility
                onTap: () => DeviceApps.openApp(app.packageName),
              );
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _dismissButton(BuildContext context) {
    return IconButton(
      color: Colors.black, // Adjusted for visibility against white background
      onPressed: () async {
        await AlertDialogService.closeAlertDialog();
      },
      icon: Icon(
        Icons.close,
      ),
    );
  }
}
