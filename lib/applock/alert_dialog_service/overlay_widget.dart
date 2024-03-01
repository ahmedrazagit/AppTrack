import 'package:flutter_application_1/applock/alert_dialog_service/widgets/alert_dialog_header.dart';
import 'package:flutter/material.dart';

class OverlayWidget extends StatelessWidget {
  Map<String, double> timeData = {"time": 0.5};

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color:
              Colors.black87, // Keeping the semi-transparent black background
        ),
        height: screenHeight, // Full screen height
        width: screenWidth, // Full screen width
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AlertDialogHeader(),
          ],
        ),
      ),
    );
  }
}
