import Flutter
import UIKit

public class SwiftLocationPermissionPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "location_permission", binaryMessenger: registrar.messenger())
    let instance = SwiftLocationPermissionPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      if(call.method == "request_permission"){
            LocationManager.shared.requestLocationAuthorization(completion: { status in
                result(status)
            })
      }else if(call.method == "open_settings"){
          LocationManager.shared.openSettings()
          result("not_always")
      }else {
          result(FlutterMethodNotImplemented)
      }
  }
}
