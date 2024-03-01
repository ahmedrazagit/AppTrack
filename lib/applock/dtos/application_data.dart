import 'dart:typed_data';

import 'package:hive/hive.dart';

part 'application_data.g.dart';

/*@HiveType(typeId: 0)
class ApplicationData {
  @HiveField(0)
  String appId;

  @HiveField(1)
  String appName;

  @HiveField(2)
  Uint8List? icon;

  ApplicationData(this.appName, this.appId, this.icon);
}*/

@HiveType(typeId: 0)
class ApplicationData {
  @HiveField(0)
  String appId;

  @HiveField(1)
  String appName;

  @HiveField(2)
  Uint8List? icon;

  @HiveField(3) // New field for usage limit
  int usageLimit; // Usage limit in minutes

  //ApplicationData(this.appName, this.appId, this.icon, this.usageLimit);

  // Adjust constructor to ensure usageLimit is never null
  ApplicationData({
    required this.appName,
    required this.appId,
    this.icon,
    int?
        usageLimit, // Allow passing null but default to 0 inside the constructor
  }) : usageLimit = usageLimit ?? 0; // Assign default value if null is passed
}
