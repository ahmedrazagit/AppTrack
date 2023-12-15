// Import necessary packages
import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Screen Time Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ScreenTimeHomePage(),
    );
  }
}

class ScreenTimeHomePage extends StatefulWidget {
  const ScreenTimeHomePage({super.key});

  @override
  State<ScreenTimeHomePage> createState() => _ScreenTimeHomePageState();
}

class _ScreenTimeHomePageState extends State<ScreenTimeHomePage> {
  int _usedTime = 0;
  int _dailyLimit = 120; // 2 hours in minutes
  bool _isTimerRunning = false;
  int _elapsedTime = 0;

  List<String> _completedGoals = [];
  List<String> _completedRecommendations = [];

  void _incrementUsedTime(int minutes) {
    setState(() {
      _usedTime += minutes;
      if (_usedTime > _dailyLimit) {
        _showLimitExceededAlert();
      }
    });
  }

  void _showLimitExceededAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Screen Time Limit Exceeded'),
          content:
              const Text('You have exceeded your daily screen time limit.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _startStopTimer() {
    setState(() {
      if (_isTimerRunning) {
        _isTimerRunning = false;
        _elapsedTime = 0;
        _showGoalsAndRecommendations(); // Show goals and recommendations when the timer is stopped.
      } else {
        _isTimerRunning = true;
        _startTimer();
      }
    });
  }

  void _startTimer() {
    const oneMinute = Duration(minutes: 1);
    Timer.periodic(oneMinute, (Timer timer) {
      if (!_isTimerRunning) {
        timer.cancel();
      } else {
        setState(() {
          _elapsedTime++;
          _incrementUsedTime(1); // Simulate app usage for 1 minute.
          if (_elapsedTime >= _dailyLimit) {
            timer.cancel();
            _showLimitExceededAlert();
          }
        });
      }
    });
  }

  void _showGoalsAndRecommendations() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GoalsAndRecommendationsPage(
          completedGoals: _completedGoals,
          completedRecommendations: _completedRecommendations,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Screen Time Manager'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Your total screen time today:',
            ),
            Text(
              '$_usedTime minutes',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            Text(
              'Daily Limit: $_dailyLimit minutes',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _startStopTimer,
        tooltip: _isTimerRunning ? 'Stop Timer' : 'Start Timer',
        child: _isTimerRunning
            ? const Icon(Icons.stop)
            : const Icon(Icons.play_arrow),
      ),
    );
  }
}

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List<String> goals = [];
  List<String> recommendations = [];

  TextEditingController goalController = TextEditingController();
  TextEditingController recommendationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Goals for the Day:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            _buildGoalList(),
            _buildAddGoalTextField(),
            const SizedBox(height: 20),
            Text(
              'Recommendations:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            _buildRecommendationList(),
            _buildAddRecommendationTextField(),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalList() {
    return Column(
      children: goals.map((goal) => ListTile(title: Text(goal))).toList(),
    );
  }

  Widget _buildRecommendationList() {
    return Column(
      children: recommendations
          .map((recommendation) => ListTile(title: Text(recommendation)))
          .toList(),
    );
  }

  Widget _buildAddGoalTextField() {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            controller: goalController,
            decoration: InputDecoration(labelText: 'Add a goal'),
          ),
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            setState(() {
              goals.add(goalController.text);
              goalController.clear();
            });
          },
        ),
      ],
    );
  }

  Widget _buildAddRecommendationTextField() {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            controller: recommendationController,
            decoration: InputDecoration(labelText: 'Add a recommendation'),
          ),
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            setState(() {
              recommendations.add(recommendationController.text);
              recommendationController.clear();
            });
          },
        ),
      ],
    );
  }
}

class GoalsAndRecommendationsPage extends StatelessWidget {
  final List<String> completedGoals;
  final List<String> completedRecommendations;

  GoalsAndRecommendationsPage({
    required this.completedGoals,
    required this.completedRecommendations,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Completed Goals and Recommendations'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Completed Goals:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            _buildCompletedGoalsList(),
            const SizedBox(height: 20),
            Text(
              'Completed Recommendations:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            _buildCompletedRecommendationsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildCompletedGoalsList() {
    return Column(
      children:
          completedGoals.map((goal) => ListTile(title: Text(goal))).toList(),
    );
  }

  Widget _buildCompletedRecommendationsList() {
    return Column(
      children: completedRecommendations
          .map((recommendation) => ListTile(title: Text(recommendation)))
          .toList(),
    );
  }
}
