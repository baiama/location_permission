#import "LocationPermissionPlugin.h"
#if __has_include(<location_permission/location_permission-Swift.h>)
#import <location_permission/location_permission-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "location_permission-Swift.h"
#endif

@implementation LocationPermissionPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftLocationPermissionPlugin registerWithRegistrar:registrar];
}
@end
