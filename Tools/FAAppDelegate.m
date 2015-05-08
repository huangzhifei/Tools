//
//  FAAppDelegate.m
//  FirstAll
//
//  Created by huangzhifei on 15-3-26.
//  Copyright (c) 2015年 huangzhifei. All rights reserved.
//

#import "FAAppDelegate.h"

@implementation FAAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    alarmPlay = [AlarmSound sharedInstance];
    
    alarmView = [[FAAlarmViewController alloc] init];
    
    //设置屏幕过一段时间后不锁屏
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    
    UILocalNotification *localNoti = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if( localNoti )
    {
        [self.window.rootViewController presentViewController:alarmView animated:YES completion:nil];
    }
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    if ([notification userInfo] && [[notification userInfo] objectForKey:@"AlarmID"])
    {
        NSLog(@"alarm clocking");
        
        NSURL *soundName = [[NSBundle mainBundle] URLForResource:notification.soundName withExtension:nil];
        
        //__strong NSURL *avName = [NSURL URLWithString: soundName];
        
        [alarmPlay play:soundName];
        
        //不是后台
        if( [UIApplication sharedApplication].applicationState == UIApplicationStateActive )
        {
            
        }
        else
        {
            
        }
        
        [self.window.rootViewController presentViewController:alarmView animated:YES completion:nil];
        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:notification.alertBody delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
//        
//        [alert show];

    }
}

- (void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [alarmPlay stop];
}
@end
