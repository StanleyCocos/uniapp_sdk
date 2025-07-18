#import "DCUniMP.h"
#import "UniappSdkPlugin.h"

@interface UniappSdkPlugin () <UIApplicationDelegate, DCUniMPSDKEngineDelegate>

@property(nonatomic, strong) FlutterMethodChannel *channel;

@end

@implementation UniappSdkPlugin

id SafeValueForKey(NSDictionary *dict, NSString *key, id defaultValue) {
    id value = dict[key];
    if (value == nil || [value isKindOfClass:[NSNull class]]) {
        return defaultValue;
    }
    return value;
}

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
    NSLog(@"ddd");
  FlutterMethodChannel *channel =
      [FlutterMethodChannel methodChannelWithName:@"uniapp_sdk"
                                  binaryMessenger:[registrar messenger]];
  UniappSdkPlugin *instance = [[UniappSdkPlugin alloc] init];
    instance.channel = channel;
  [DCUniMPSDKEngine setDelegate:instance];
  [registrar addApplicationDelegate:instance];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall *)call
                  result:(FlutterResult)result {
  if ([@"open" isEqualToString:call.method]) {
    [self open:call result:result];
  } else if ([@"install" isEqualToString:call.method]) {
    [self install:call result:result];
  } else if ([@"getVersionInfo" isEqualToString:call.method]) {
    [self getVersionInfo:call result:result];
  } else if ([@"isExist" isEqualToString:call.method]) {
    [self isExist:call result:result];
  } else {
    result(FlutterMethodNotImplemented);
  }
}

# pragma mark uniapp 方法

- (void)open:(FlutterMethodCall *)call result:(FlutterResult)result {
  NSString *appId = call.arguments[@"id"];
  NSDictionary *config = call.arguments[@"config"];

    DCUniMPConfiguration *configuration = [[DCUniMPConfiguration alloc] init];
    if(config != nil){
        configuration.path = SafeValueForKey(config, @"path", nil);
        configuration.extraData = SafeValueForKey(config, @"path", nil);
        configuration.showAnimated = SafeValueForKey(config, @"showAnimated", @YES);
        configuration.hideAnimated = SafeValueForKey(config, @"hideAnimated", @YES);
        configuration.fromAppid = SafeValueForKey(config, @"fromAppid", nil);
        configuration.enableBackground = SafeValueForKey(config, @"enableBackground", @NO);
        configuration.enableGestureClose = SafeValueForKey(config, @"enableGestureClose", @NO);
        NSString * mode = SafeValueForKey(config, @"openMode", @"present");
        if([@"push" isEqualToString: mode]){
            configuration.openMode = DCUniMPOpenModePush;
        } else {
            configuration.openMode = DCUniMPOpenModePresent;
        }
    }

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

- (void)install:(FlutterMethodCall *)call result:(FlutterResult)result {
  NSString *appId = call.arguments[@"id"];
  NSString *path = call.arguments[@"path"];
  NSString *password = call.arguments[@"password"];

  NSError *error;
  if ([DCUniMPSDKEngine installUniMPResourceWithAppid:appId
                                     resourceFilePath:path
                                             password:password
                                                error:&error]) {
    result(@YES);
  } else {
    result(@NO);
  }
}

- (void)getVersionInfo:(FlutterMethodCall *)call result:(FlutterResult)result {
  NSString *appId = call.arguments[@"id"];

  result([DCUniMPSDKEngine getUniMPVersionInfoWithAppid:appId]);
}

- (void)isExist:(FlutterMethodCall *)call result:(FlutterResult)result {
  NSString *appId = call.arguments[@"id"];
  if ([DCUniMPSDKEngine isExistsUniMP:appId]) {
    result(@YES);
  } else {
    result(@NO);
  }
}

#pragma mark - App 生命周期

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [DCUniMPSDKEngine initSDKEnvironmentWithLaunchOptions:launchOptions];
  return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  [DCUniMPSDKEngine applicationDidBecomeActive:application];
}

- (void)applicationWillResignActive:(UIApplication *)application {
  [DCUniMPSDKEngine applicationWillResignActive:application];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  [DCUniMPSDKEngine applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  [DCUniMPSDKEngine applicationWillEnterForeground:application];
}

- (void)applicationWillTerminate:(UIApplication *)application {
  [DCUniMPSDKEngine destory];
}


# pragma mark - DCUniMPSDKEngineDelegate

- (void)uniMPOnClose:(NSString *)appid {
    [self.channel invokeMethod:@"onClose" arguments:@{@"id": appid, @"type": @"1"}];
}

- (void)closeButtonClicked:(NSString *)appid {
    [self.channel invokeMethod:@"onClose" arguments:@{@"id": appid, @"type": @"2"}];
}
@end



