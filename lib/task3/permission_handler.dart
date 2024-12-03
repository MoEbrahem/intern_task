import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationPermissionHandler {
  static Future<bool> checkLocationPermission(BuildContext context) async {
    var status = await Permission.locationWhenInUse.status;

    if (status.isGranted) {
      return true;
    } 
    else if (status.isDenied || status.isLimited) {

      status = await Permission.locationWhenInUse.request();

      if (status.isGranted) {
        return true;
      } 
      else if (status.isPermanentlyDenied) {
      
        openSettingsforPermissionDialog(context);
      }
    }

    return false;
  }

  static openSettingsforPermissionDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Location Permission Required'),
        content: const Text(
          'Please enable location permission in settings to use this feature.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              openAppSettings();
              Navigator.pop(context);
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }
}
