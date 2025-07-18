#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
    BOOL result = [super application:application didFinishLaunchingWithOptions:launchOptions];
    UIViewController *vc = self.window.rootViewController;
    if(vc != nil){
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController: vc];
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.window.rootViewController = nav;
        [nav setNavigationBarHidden:YES animated:NO];
        [self.window makeKeyAndVisible];
    }
    return result;
}
@end
