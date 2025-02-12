
#import "DCUniMP.h"
#import "FlutterUniappSdkPlugin.h"

@implementation FlutterUniappSdkPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
  FlutterMethodChannel *channel =
      [FlutterMethodChannel methodChannelWithName:@"flutter_uniapp_sdk"
                                  binaryMessenger:[registrar messenger]];
  FlutterUniappSdkPlugin *instance = [[FlutterUniappSdkPlugin alloc] init];
  [registrar addApplicationDelegate:instance];
  [registrar addMethodCallDelegate:instance channel:channel];
}

#pragma mark - ApplicationDelegate
- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [DCUniMPSDKEngine initSDKEnvironmentWithLaunchOptions:launchOptions];
  return YES;
}

- (void)handleMethodCall:(FlutterMethodCall *)call
                  result:(FlutterResult)result {
    NSLog(@"method: %@", call.method);
    NSLog(@"arguments: %@", call.arguments);
  if ([@"open" isEqualToString:call.method]) {
      [self open:call result:result];
  } else if ([@"install" isEqualToString:call.method]) {
      [self install:call result:result];
  } else if ([@"preload" isEqualToString:call.method]) {

  } else {
    result(FlutterMethodNotImplemented);
  }
}

- (void)open:(FlutterMethodCall *)call
      result:(FlutterResult)result  {
    NSString * appId = call.arguments[@"appId"];
    
  DCUniMPConfiguration *configuration = [[DCUniMPConfiguration alloc] init];
  [DCUniMPSDKEngine openUniMP:appId
                configuration:configuration
                    completed:^(DCUniMPInstance *_Nullable uniMPInstance,
                                NSError *_Nullable error) {
                      if (uniMPInstance) {
                          result(@YES);
                      } else {
                          result(@NO);
                      }
                    }];
}

- (void)install:(FlutterMethodCall *)call
         result:(FlutterResult)result {
    NSString * appId = call.arguments[@"appId"];
    NSString * path = call.arguments[@"path"];
    NSString * password = call.arguments[@"password"];
    
    NSError *error;
    if ([DCUniMPSDKEngine installUniMPResourceWithAppid:appId resourceFilePath:path password:password error:&error]) {
        result(@YES);
            } else {
                result(@NO);
            }
}


@end
