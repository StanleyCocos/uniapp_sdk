#import "DCUniMP.h"
#import "UniappSdkPlugin.h"

@implementation UniappSdkPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
  FlutterMethodChannel *channel =
      [FlutterMethodChannel methodChannelWithName:@"uniapp_sdk"
                                  binaryMessenger:[registrar messenger]];
  UniappSdkPlugin *instance = [[UniappSdkPlugin alloc] init];
  [registrar addApplicationDelegate:instance];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall *)call
                  result:(FlutterResult)result {
    NSLog(@"name: %@", call.method);
    NSLog(@"name: %@", call.arguments);
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

- (void)open:(FlutterMethodCall *)call result:(FlutterResult)result {

  NSString *appId = call.arguments[@"id"];

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

- (void)install:(FlutterMethodCall *)call result:(FlutterResult)result {
  NSString *appId = call.arguments[@"id"];
  NSString *path = call.arguments[@"path"];
  NSString *password = call.arguments[@"password"];

  NSError *error;
  if ([DCUniMPSDKEngine installUniMPResourceWithAppid:appId
                                     resourceFilePath:path
                                             password:nil
                                                error:&error]) {
      NSLog(@"小程序 %@ 应用资源文件部署成功，版本信息：%@",appId,[DCUniMPSDKEngine getUniMPVersionInfoWithAppid:appId]);
    result(@YES);
  } else {
      NSLog(@"小程序 %@ 应用资源部署失败： %@",appId,error);
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
    NSLog(@"application didFinishLaunchingWithOptions");
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
@end
