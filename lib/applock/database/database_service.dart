/*import 'package:flutterchallenge/dtos/application_data.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class DatabaseService {

  bool _isInitialized = false;
  // static final Finalizer<Box<ApplicationData>> _finalizer =
  // Finalizer((box) => box.close());


  final String _boxName = "application-data";
  late Box<ApplicationData> _box;

  static Future<DatabaseService> instance() async {
    DatabaseService dbService = DatabaseService();
    await dbService.initializeHive();
    await dbService.registerAdapters();
    await dbService.openBox();
    return dbService;
  }

  Future<void> initializeHive() async {
    await Hive.initFlutter();
  }

  registerAdapters() {
    if(!_isInitialized) {
      Hive.registerAdapter(ApplicationDataAdapter());
      _isInitialized = true;
    }
  }

  Future<void> openBox() async {
    if(Hive.isBoxOpen(_boxName)) {
      debugPrint("Reopening the box so closing it first!");
      await close();
    }

    debugPrint("Opening the box!");
    _box = await Hive.openBox(_boxName);
  }

  Future<void> close() async {
    if(Hive.isBoxOpen(_boxName)) {
      debugPrint("Closing the box!");
      await _box.close();
      //_finalizer.detach(this);
    } else {
      debugPrint("Box not open!");
    }
  }

  ApplicationData? getAppData(String appId) {
    return _box.get(appId);
  }

  List<ApplicationData> getAllAppData() {
    return _box.values.toList();
  }

  List<String> getAllAppPackageNames() {
    return _box.keys.map((e) => e as String).toList();
  }

  Future<void> addAppData(ApplicationData appData) async {
    debugPrint("Adding ${appData.appId} to box!");
    await _box.put(appData.appId, appData);
  }

  Future<void> addAllAppData(List<ApplicationData> appDatas) async {
    for(ApplicationData appData in appDatas) {
      await addAppData(appData);
    }
  }

  Future<void> updateAllAppData(List<ApplicationData> appDatas) async {
    await _box.clear();
    for(ApplicationData appData in appDatas) {
      await addAppData(appData);
    }
  }

  Map<dynamic, ApplicationData> getBoxAsMap() {
    return _box.toMap();
  }

  Future<void> removeAppData(String appId) async {
    debugPrint("Removing $appId from box!");
    await _box.delete(appId);
  }
}*/

/*import 'package:flutterchallenge/dtos/application_data.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DatabaseService {
  bool _isInitialized = false;

  final String _boxName = "application-data";
  late Box<ApplicationData> _box;

  static Future<DatabaseService> instance() async {
    DatabaseService dbService = DatabaseService();
    await dbService.initializeHive();
    await dbService.registerAdapters();
    await dbService.openBox();
    return dbService;
  }

  Future<void> initializeHive() async {
    await Hive.initFlutter();
  }

  registerAdapters() {
    if (!_isInitialized) {
      Hive.registerAdapter(ApplicationDataAdapter());
      _isInitialized = true;
    }
  }

  Future<void> openBox() async {
    if (Hive.isBoxOpen(_boxName)) {
      debugPrint("Reopening the box so closing it first!");
      await close();
    }

    debugPrint("Opening the box!");
    _box = await Hive.openBox<ApplicationData>(_boxName);
  }

  Future<void> close() async {
    if (Hive.isBoxOpen(_boxName)) {
      debugPrint("Closing the box!");
      await _box.close();
    } else {
      debugPrint("Box not open!");
    }
  }

  ApplicationData? getAppData(String appId) {
    return _box.get(appId);
  }

  List<ApplicationData> getAllAppData() {
    return _box.values.toList();
  }

  List<String> getAllAppPackageNames() {
    return _box.keys.cast<String>().toList();
  }

  Future<void> addAppData(ApplicationData appData) async {
    debugPrint("Adding ${appData.appId} to box!");
    await _box.put(appData.appId, appData);
  }

  Future<void> addAllAppData(List<ApplicationData> appDatas) async {
    for (ApplicationData appData in appDatas) {
      await addAppData(appData);
    }
  }

  Future<void> updateAppUsageLimit(String appId, int limit) async {
    final appData = getAppData(appId);
    if (appData != null) {
      // Update the appData with the new usage limit
      final updatedAppData = ApplicationData(
          appData.appName, appData.appId, appData.icon, appData.usageLimit);
      await _box.put(appId, updatedAppData);
      debugPrint("Updated usage limit for $appId to $limit minutes");
    }
  }

  Future<void> updateAllAppData(List<ApplicationData> appDatas) async {
    await _box.clear();
    for (ApplicationData appData in appDatas) {
      await addAppData(appData);
    }
  }

  Map<dynamic, ApplicationData> getBoxAsMap() {
    return _box.toMap();
  }

  Future<void> removeAppData(String appId) async {
    debugPrint("Removing $appId from box!");
    await _box.delete(appId);
  }
}*/

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_application_1/applock/dtos/application_data.dart';

class DatabaseService {
  bool _isInitialized = false;

  final String _boxName = "application-data";
  late Box<ApplicationData> _box;

  static final DatabaseService _instance = DatabaseService._internal();

  DatabaseService._internal();

  static Future<DatabaseService> instance() async {
    if (!_instance._isInitialized) {
      await _instance.initializeHive();
      _instance.registerAdapters();
      await _instance.openBox();
    }
    return _instance;
  }

  Future<void> initializeHive() async {
    await Hive.initFlutter();
  }

  void registerAdapters() {
    if (!_isInitialized) {
      Hive.registerAdapter(ApplicationDataAdapter());
      _isInitialized = true;
    }
  }

  Future<void> openBox() async {
    if (Hive.isBoxOpen(_boxName)) {
      debugPrint("Reopening the box so closing it first!");
      await close();
    }

    debugPrint("Opening the box!");
    _box = await Hive.openBox<ApplicationData>(_boxName);
  }

  Future<void> close() async {
    if (Hive.isBoxOpen(_boxName)) {
      debugPrint("Closing the box!");
      await _box.close();
    } else {
      debugPrint("Box not open!");
    }
  }

  ApplicationData? getAppData(String appId) {
    return _box.get(appId);
  }

  List<ApplicationData> getAllAppData() {
    return _box.values.toList();
  }

  List<String> getAllAppPackageNames() {
    return _box.keys.cast<String>().toList();
  }

  Future<void> addAppData(ApplicationData appData) async {
    debugPrint("Adding ${appData.appId} to box!");
    await _box.put(appData.appId, appData);
  }

  Future<void> addAllAppData(List<ApplicationData> appDatas) async {
    for (ApplicationData appData in appDatas) {
      await addAppData(appData);
    }
  }

  Future<void> updateAppUsageLimit(String appId, int limit) async {
    final appData = getAppData(appId);
    if (appData != null) {
      // Ensure all arguments are correctly referenced from `appData`
      final updatedAppData = ApplicationData(
        appName: appData.appName, // Correctly reference appName from appData
        appId: appData.appId, // appId is correctly referenced
        icon: appData.icon, // icon is correctly referenced
        usageLimit: limit, // Pass the new limit
      );
      await _box.put(appId, updatedAppData);
      debugPrint("Updated usage limit for $appId to $limit minutes");
    }
  }

  Future<int> getAppUsageLimit(String appId) async {
    final appData = getAppData(appId);
    return appData?.usageLimit ??
        0; // Provides the usage limit or defaults to 0 if not found
  }

  Future<void> updateAllAppData(List<ApplicationData> appDatas) async {
    await _box.clear();
    for (ApplicationData appData in appDatas) {
      await addAppData(appData);
    }
  }

  Map<dynamic, ApplicationData> getBoxAsMap() {
    return _box.toMap();
  }

  Future<void> removeAppData(String appId) async {
    debugPrint("Removing $appId from box!");
    await _box.delete(appId);
  }
}
