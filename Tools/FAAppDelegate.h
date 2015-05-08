//
//  FAAppDelegate.h
//  FirstAll
//
//  Created by huangzhifei on 15-3-26.
//  Copyright (c) 2015年 huangzhifei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlarmSound.h"
#import "FAAlarmViewController.h"
@interface FAAppDelegate : UIResponder <UIApplicationDelegate, UIAlertViewDelegate>
{
    AlarmSound *alarmPlay;
    FAAlarmViewController *alarmView;
}

@property (strong, nonatomic) UIWindow *window;
//@property (strong, nonatomic) FAAlarmViewController *alarmView;
@end
