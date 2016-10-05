//
//  AppDelegate.m
//  DABFormation2
//
//  Created by mac mini pprod 3 on 17/02/2016.
//  Copyright © 2016 mac mini pprod 3. All rights reserved.
//

#import "AppDelegate.h"
#import "DataManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    
    //Actions
    UIMutableUserNotificationAction *firstAction = [[UIMutableUserNotificationAction alloc] init];
    firstAction.identifier = @"FIRST_ACTION";
    firstAction.title = @"utiliser la première action";
    firstAction.activationMode = UIUserNotificationActivationModeForeground;
    firstAction.destructive = NO;
    firstAction.authenticationRequired = NO;
    
    UIMutableUserNotificationAction *secondAction = [[UIMutableUserNotificationAction alloc] init];
    secondAction.identifier = @"SECOND_ACTION";
    secondAction.title = @"2nd action";
    secondAction.activationMode = UIUserNotificationActivationModeBackground;
    secondAction.destructive = YES;
    secondAction.authenticationRequired = NO;
    
    //Categories
    UIMutableUserNotificationCategory *testCategory = [[UIMutableUserNotificationCategory alloc] init];
    testCategory.identifier = @"TEST_CATEGORY";
    [testCategory setActions:@[secondAction, firstAction] forContext:UIUserNotificationActionContextDefault];
    [testCategory setActions:@[secondAction, firstAction] forContext:UIUserNotificationActionContextMinimal];
    
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:[NSSet setWithObject:testCategory]];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    // set notification
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = [[NSDate date] dateByAddingTimeInterval:2];
    localNotification.timeZone = [NSTimeZone systemTimeZone];
    localNotification.alertTitle = @"Nouvelle notification DABFormation2 !";
    localNotification.alertBody = @"test local notification with actions";
    localNotification.soundName = @"frogs.wav";
    localNotification.category = @"TEST_CATEGORY";
    localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber]+1;
    
    // schedule notification
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    
    [[DataManager sharedDataManager] saveContext];
}
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"DeviceToken : %@", deviceToken);
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)())completionHandler {
    NSLog(@"handleActionWithIdentifier");
    NSLog(@"identifier : %@", identifier);
    NSLog(@"userInfo : %@", notification.userInfo);
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    NSLog(@"didReceiveLocalNotification");
    NSLog(@"userInfo : %@", notification.userInfo);
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"userInfo : %@", userInfo);
}

@end
