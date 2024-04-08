/*import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class overlaysettings extends StatefulWidget {
  @override
  _overlaysettingsState createState() => _overlaysettingsState();
}

class _overlaysettingsState extends State<overlaysettings> {
  bool _aiRecommendationsEnabled = true;
  bool _appSelectionEnabled = true;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _aiRecommendationsEnabled =
          prefs.getBool('aiRecommendationsEnabled') ?? true;
      _appSelectionEnabled = prefs.getBool('appSelectionEnabled') ?? true;
    });
  }

  Future<void> _updatePreference(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Overlay Settings'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text('AI Recommendations'),
            value: _aiRecommendationsEnabled,
            onChanged: (bool value) {
              setState(() {
                _aiRecommendationsEnabled = value;
                _updatePreference('aiRecommendationsEnabled', value);
              });
            },
          ),
          SwitchListTile(
            title: Text('App Selection Redirection'),
            value: _appSelectionEnabled,
            onChanged: (bool value) {
              setState(() {
                _appSelectionEnabled = value;
                _updatePreference('appSelectionEnabled', value);
              });
            },
          ),
          SwitchListTile(
            title: Text('Complete Block'),
            value: _appSelectionEnabled,
            onChanged: (bool value) {
              setState(() {
                _appSelectionEnabled = value;
                _updatePreference('appSelectionEnabled', value);
              });
            },
          ),
        ],
      ),
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class overlaysettings extends StatefulWidget {
  @override
  _overlaysettingsState createState() => _overlaysettingsState();
}

class _overlaysettingsState extends State<overlaysettings> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        final prefs = snapshot.requireData;

        return Scaffold(
          appBar: AppBar(
            title: Text('Overlay Settings'),
          ),
          body: ListView(
            children: [
              SwitchListTile(
                title: Text('AI Recommendations'),
                value: prefs.getBool('aiRecommendationsEnabled') ?? true,
                onChanged: (value) => prefs
                    .setBool('aiRecommendationsEnabled', value)
                    .then((_) => setState(() {})),
              ),
              SwitchListTile(
                title: Text('App Selection Redirection'),
                value: prefs.getBool('appSelectionEnabled') ?? true,
                onChanged: (value) => prefs
                    .setBool('appSelectionEnabled', value)
                    .then((_) => setState(() {})),
              ),
              SwitchListTile(
                title: Text('Complete Block'),
                value: prefs.getBool('completeBlockEnabled') ?? false,
                onChanged: (value) => prefs
                    .setBool('completeBlockEnabled', value)
                    .then((_) => setState(() {})),
              ),
            ],
          ),
        );
      },
    );
  }
}
