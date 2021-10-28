import 'dart:async';

import 'package:flutter/services.dart';

class LocationPermission {
  static const MethodChannel _channel = MethodChannel('location_permission');

  static Future<String> requestLocationPermission() async {
    String status = await _channel.invokeMethod('request_permission');
    return status;
    // if (currentStatus == "not_determined") {
    //   return await _requestPermission();
    // }
    // return _convertStatus(currentStatus);
  }

  static void openSettings() {
    _channel.invokeMethod('open_settings');
  }

  static Future<String> _getLocationStatus() async {
    try {
      String status = await _channel.invokeMethod('get_location_status');
      return status;
    } on PlatformException {
      return "error";
    }
  }

  static Future<LocationPermissionStatus> _requestPermission() async {
    try {
      String status = await _channel.invokeMethod('request_permission');
      return _convertStatus(status);
    } on PlatformException {
      return LocationPermissionStatus.error;
    }
  }

  static LocationPermissionStatus _convertStatus(String status) {
    if (status == 'always') {
      return LocationPermissionStatus.always;
    } else if (status == 'authorized_when_in_use') {
      return LocationPermissionStatus.authorizedWhenInUse;
    } else if (status == 'denied') {
      return LocationPermissionStatus.denied;
    }
    return LocationPermissionStatus.error;
  }
}

enum LocationPermissionStatus {
  always,
  denied,
  authorizedWhenInUse,
  error,
}
