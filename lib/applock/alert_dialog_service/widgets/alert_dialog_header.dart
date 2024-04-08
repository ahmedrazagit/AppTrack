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

/*import 'package:flutter/material.dart';
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
}*/

/*import 'package:flutter/material.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart'; // Import the SDK
import 'package:flutter_application_1/applock/alert_dialog_service/alert_dialog_service.dart';
import 'package:flutter_application_1/applock/main_app_ui/utils/fonts.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter_application_1/screens/const.dart';

class AlertDialogHeader extends StatefulWidget {
  @override
  _AlertDialogHeaderState createState() => _AlertDialogHeaderState();
}

class _AlertDialogHeaderState extends State<AlertDialogHeader> {
  late OpenAI openAI;
  String _recommendation = "Fetching recommendation...";

  @override
  void initState() {
    super.initState();
    // Initialize the OpenAI instance with your API key and other configurations
    openAI = OpenAI.instance.build(
      token: OPENAI_API_KEY,
      baseOption: HttpSetup(
        receiveTimeout: const Duration(seconds: 20),
        connectTimeout: const Duration(seconds: 20),
      ),
      enableLog: true,
    );
    _fetchRecommendation();
  }

  void _fetchRecommendation() async {
    final request = ChatCompleteText(
      messages: [
        Messages(
            role: Role.user, content: "Suggest a healthy activity for a break")
      ],
      maxToken: 100,
      model: GptTurbo0301ChatModel(),
    );

    try {
      ChatCTResponse? response =
          await openAI.onChatCompletion(request: request);
      print("Response received: ${response?.choices.last.message?.content}");
      if (response != null &&
          response.choices.isNotEmpty &&
          response.choices.last.message != null) {
        setState(() {
          _recommendation = response.choices.last.message!.content.trim();
        });
      } else {
        setState(() {
          _recommendation = "No recommendation found.";
        });
      }
    } catch (e) {
      print("Error fetching recommendation: $e");
      setState(() {
        _recommendation = "Error fetching recommendation: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          width: screenWidth * 0.9,
          height: screenHeight * 0.8,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Time is Up",
                    style: Fonts.header3(color: Colors.black)),
              ),
              SizedBox(height: 10),
              Expanded(
                child: _buildAppList(context),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  _recommendation,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
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
      color: Colors.black,
      onPressed: () async {
        await AlertDialogService.closeAlertDialog();
      },
      icon: Icon(Icons.close),
    );
  }
}*/

/*import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter_application_1/applock/alert_dialog_service/alert_dialog_service.dart';
import 'package:flutter_application_1/applock/main_app_ui/utils/fonts.dart';
import 'package:flutter_application_1/screens/const.dart'; // Assuming this is where OPENAI_API_KEY is defined
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';

class AlertDialogHeader extends StatefulWidget {
  @override
  _AlertDialogHeaderState createState() => _AlertDialogHeaderState();
}

class _AlertDialogHeaderState extends State<AlertDialogHeader> {
  late OpenAI openAI;
  String _recommendation = "Fetching recommendation...";
  bool _aiRecommendationsEnabled = true;
  bool _appSelectionEnabled = true;

  @override
  void initState() {
    super.initState();
    _loadPreferences().then((_) {
      if (_aiRecommendationsEnabled) {
        openAI = OpenAI.instance.build(
          token: OPENAI_API_KEY,
          baseOption: HttpSetup(
            receiveTimeout: const Duration(seconds: 20),
            connectTimeout: const Duration(seconds: 20),
          ),
          enableLog: true,
        );
        _fetchRecommendation();
      }
    });
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _aiRecommendationsEnabled =
          prefs.getBool('aiRecommendationsEnabled') ?? true;
      _appSelectionEnabled = prefs.getBool('appSelectionEnabled') ?? true;
    });
  }

  void _fetchRecommendation() async {
    final request = ChatCompleteText(
      messages: [
        Messages(
            role: Role.user, content: "Suggest a healthy activity for a break and dont mention that you are an ai model, just generate a list of the options")
      ],
      maxToken: 100,
      model: GptTurbo0301ChatModel(),
    );

    try {
      ChatCTResponse? response =
          await openAI.onChatCompletion(request: request);
      print("Response received: ${response?.choices.last.message?.content}");
      if (response != null &&
          response.choices.isNotEmpty &&
          response.choices.last.message != null) {
        setState(() {
          _recommendation = response.choices.last.message!.content.trim();
        });
      } else {
        setState(() {
          _recommendation = "No recommendation found.";
        });
      }
    } catch (e) {
      print("Error fetching recommendation: $e");
      setState(() {
        _recommendation = "Error fetching recommendation: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          width: screenWidth * 0.9,
          height: screenHeight * 0.8,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Time is Up",
                    style: Fonts.header3(color: Colors.black)),
              ),
              SizedBox(height: 10),
              _aiRecommendationsEnabled
                  ? Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        _recommendation,
                        style: TextStyle(fontSize: 16, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : Container(),
              _appSelectionEnabled
                  ? Expanded(
                      child: _buildAppList(context),
                    )
                  : Container(),
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
      color: Colors.black,
      onPressed: () async {
        await AlertDialogService.closeAlertDialog();
      },
      icon: Icon(Icons.close),
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter_application_1/applock/alert_dialog_service/alert_dialog_service.dart';
import 'package:flutter_application_1/applock/main_app_ui/utils/fonts.dart';
import 'package:flutter_application_1/screens/const.dart'; // Assuming this is where OPENAI_API_KEY is defined
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';

class AlertDialogHeader extends StatefulWidget {
  @override
  _AlertDialogHeaderState createState() => _AlertDialogHeaderState();
}

class _AlertDialogHeaderState extends State<AlertDialogHeader> {
  late OpenAI openAI;
  String _recommendation = "Fetching recommendation...";
  bool _aiRecommendationsEnabled = true;
  bool _appSelectionEnabled = true;
  bool _completeBlockEnabled = false; // New variable

  @override
  void initState() {
    super.initState();
    _loadPreferences().then((_) {
      if (_aiRecommendationsEnabled) {
        openAI = OpenAI.instance.build(
          token: OPENAI_API_KEY,
          baseOption: HttpSetup(
            receiveTimeout: const Duration(seconds: 20),
            connectTimeout: const Duration(seconds: 20),
          ),
          enableLog: true,
        );
        _fetchRecommendation();
      }
    });
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _aiRecommendationsEnabled =
          prefs.getBool('aiRecommendationsEnabled') ?? true;
      _appSelectionEnabled = prefs.getBool('appSelectionEnabled') ?? true;
      _completeBlockEnabled =
          prefs.getBool('completeBlockEnabled') ?? false; // Load preference
    });
  }

  void _fetchRecommendation() async {
    final request = ChatCompleteText(
      messages: [
        Messages(
            role: Role.user,
            content:
                "Suggest a healthy activity for a break and dont mention that you are an ai model, just generate a list of the options")
      ],
      maxToken: 100,
      model: GptTurbo0301ChatModel(),
    );

    try {
      ChatCTResponse? response =
          await openAI.onChatCompletion(request: request);
      print("Response received: ${response?.choices.last.message?.content}");
      if (response != null &&
          response.choices.isNotEmpty &&
          response.choices.last.message != null) {
        setState(() {
          _recommendation = response.choices.last.message!.content.trim();
        });
      } else {
        setState(() {
          _recommendation = "No recommendation found.";
        });
      }
    } catch (e) {
      print("Error fetching recommendation: $e");
      setState(() {
        _recommendation = "Error fetching recommendation: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          width: screenWidth * 0.9,
          height: screenHeight * 0.8,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Time is Up",
                    style: Fonts.header3(color: Colors.black)),
              ),
              SizedBox(height: 10),
              _aiRecommendationsEnabled
                  ? Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        _recommendation,
                        style: TextStyle(fontSize: 16, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : Container(),
              _appSelectionEnabled
                  ? Expanded(
                      child: _buildAppList(context),
                    )
                  : Container(),
              _completeBlockEnabled
                  ? Container()
                  : _dismissButton(context), // Conditionally displayed
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
      color: Colors.black,
      onPressed: () async {
        await AlertDialogService.closeAlertDialog();
      },
      icon: Icon(Icons.close),
    );
  }
}
