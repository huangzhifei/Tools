//
//  AlarmClockManager.h
//  FirstAll
//
//  Created by huangzhifei on 15-4-26.
//  Copyright (c) 2015年 huangzhifei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AlarmClock.h"

@interface AlarmClockManager : NSObject
{
    NSDateFormatter *dformatter;
}

+(instancetype)sharedInstance;

//原始数据集
@property (strong, nonatomic) NSMutableArray *dataContent;

- (void) scheduleLocalNotifications;

- (void) cancelAlarmLocalNotification: (UILocalNotification *) localNoti;

- (void) orderAlarmClock;

- (NSInteger) findAlarmClockLocal: (AlarmClock *) alarmClock;

@end
