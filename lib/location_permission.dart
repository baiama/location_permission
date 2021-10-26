import 'dart:async';

import 'package:flutter/services.dart';

class LocationPermission {
  static const MethodChannel _channel = MethodChannel('location_permission');

  static Future<LocationPermissionStatus> requestLocationPermission() async {
    try {
      String status = await _channel.invokeMethod('request_permission');
      if (status == 'always') {
        return LocationPermissionStatus.always;
      } else if (status == 'authorized_when_in_use') {
        return LocationPermissionStatus.authorizedWhenInUse;
      }
      return LocationPermissionStatus.denied;
    } on PlatformException {
      return LocationPermissionStatus.error;
    }
  }

  static void openSettings() {
    _channel.invokeMethod('open_settings');
  }
}

enum LocationPermissionStatus {
  always,
  denied,
  authorizedWhenInUse,
  error,
}
