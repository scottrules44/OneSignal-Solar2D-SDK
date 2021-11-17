#import <OneSignal/OneSignal.h>
#import "OneSignal.h"
#import "OneSignalCoronaDelegate.h"
#import "OneSignalHelper.h"
#import "OneSignalLocation.h"
#import "OneSignalTracker.h"

@implementation OneSignalCoronaDelegate : NSObject 

- (void)applicationWillResignActive:(UIApplication*)application {
    [OneSignal onesignalLog:ONE_S_LL_VERBOSE message:@"applicationWillResignActive:application"];
    
    if ([OneSignal appId])
        [OneSignalTracker onFocus:YES];
}

- (void)applicationDidBecomeActive:(UIApplication*)application {
    [OneSignal onesignalLog:ONE_S_LL_VERBOSE message:@"applicationDidBecomeActive:application"];
    
    if ([OneSignal appId]) {
        [OneSignalTracker onFocus:NO];
        //[OneSignalLocation onFocus:]; deprecated
    }
}

- (void)application:(UIApplication*)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)inDeviceToken {
    [OneSignal onesignalLog:ONE_S_LL_VERBOSE message:@"application:app didRegisterForRemoteNotificationsWithDeviceToken:inDeviceToken"];
    
    if ([OneSignal appId])
        [OneSignal didRegisterForRemoteNotifications:app deviceToken:inDeviceToken];
}

- (void)application:(UIApplication*)app didFailToRegisterForRemoteNotificationsWithError:(NSError*)err {
    [OneSignal onesignalLog:ONE_S_LL_VERBOSE message:@"application:app didFailToRegisterForRemoteNotificationsWithError:err"];
    
    if ([OneSignal appId])
        [OneSignal handleDidFailRegisterForRemoteNotification:err];
}

- (void)application:(UIApplication*)app didRegisterUserNotificationSettings:(UIUserNotificationSettings*)notificationSettings {
    [OneSignal onesignalLog:ONE_S_LL_VERBOSE message:@"application:app didRegisterUserNotificationSettings:notificationSettings"];
    
    if ([OneSignal appId])
        [OneSignal updateNotificationTypes:[notificationSettings types]];
}



// Notification opened or silent one received on iOS 7 & 8
- (void)application:(UIApplication*)app didReceiveRemoteNotification:(NSDictionary*)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult)) completionHandler {
    [OneSignal onesignalLog:ONE_S_LL_VERBOSE message:@"application:app didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler"];
    
    if ([OneSignal appId])
        [OneSignal remoteSilentNotification:app UserInfo:userInfo completionHandler:completionHandler];
}



- (void)willLoadMain:(id<CoronaRuntime>)runtime {}
- (void)didLoadMain:(id<CoronaRuntime>)runtime {}

@end
