//
//  AlarmClockManager.m
//  FirstAll
//
//  Created by huangzhifei on 15-4-26.
//  Copyright (c) 2015年 huangzhifei. All rights reserved.
//

#import "AlarmClockManager.h"

@implementation AlarmClockManager

static AlarmClockManager *_instance = nil;

+ (instancetype)sharedInstance
{
    if( _instance == nil )
    {
        _instance = [[AlarmClockManager alloc] init];
        
        _instance->dformatter = [[NSDateFormatter alloc] init];
        
        //[_instance->dformatter setDateFormat: @"yyyy-MM-dd hh:mm aa"];
    }
    
    return _instance;
}

- (void) scheduleLocalNotifications
{
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    /*
     最多64个本地通知，故每次只申请一个即将发生的闹铃通知，闹铃响完后注册下一个即将发生的闹铃。
     定义闹铃key为“AlarmID”
     */
    //[1]
    NSDate *nowDate = [NSDate date];
    NSDateComponents *nowMinDate;
    NSTimeInterval minInterval = 10 * 24 * 60 * 60;
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    NSDateComponents *curComps = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit
                                            fromDate:nowDate];
    int year = [curComps year];
    int month = [curComps month];
    int day = [curComps day];
    [dformatter setDateFormat: @"yyyy-MM-dd hh:mm aa"];
    AlarmClock *targetAlarm = nil;
    BOOL ret = false;
    for( AlarmClock *nowAlarm in self.dataContent )
    {
        if( nowAlarm.switchflag )
        {
            NSMutableArray *alarmDays = [NSMutableArray arrayWithObjects:@"0", @"0", @"0", @"0", @"0", @"0",@"0",@"0", nil];
            
            if( nowAlarm.sun )
            {
                [alarmDays replaceObjectAtIndex:1 withObject:@"1"];
            }
            if( nowAlarm.mon )
            {
                [alarmDays replaceObjectAtIndex:2 withObject:@"2"];
            }
            if( nowAlarm.tue )
            {
                [alarmDays replaceObjectAtIndex:3 withObject:@"3"];
            }
            if( nowAlarm.wed )
            {
                [alarmDays replaceObjectAtIndex:4 withObject:@"4"];
            }
            if( nowAlarm.thu )
            {
                [alarmDays replaceObjectAtIndex:5 withObject:@"5"];
            }
            if( nowAlarm.fri )
            {
                [alarmDays replaceObjectAtIndex:6 withObject:@"6"];
            }
            if( nowAlarm.sat )
            {
                [alarmDays replaceObjectAtIndex:7 withObject:@"7"];
            }
            
            for(int indexday = 1; indexday < [alarmDays count]; ++ indexday)
            {
                //使用NSYearCalendarUnit | NSWeekOfYearCalendarUnit这个组合，可以通过当前是周几来反向定位到年月日
                NSDateComponents *dateComps = [calendar components: NSYearCalendarUnit | NSWeekOfYearCalendarUnit |
                                               NSWeekdayCalendarUnit |  NSHourCalendarUnit |
                                               NSMinuteCalendarUnit fromDate:nowDate];
                
                //dateComps.weekday = 3;
                
                NSString *alarmTimeString = [nowAlarm.date stringByAppendingString:(nowAlarm.am ? @" AM" : @" PM")];
                NSString *alarmYMDString = [NSString stringWithFormat:@"%d-%02d-%02d ",year,month,day];
                NSString *alarmDateString = [alarmYMDString stringByAppendingString:alarmTimeString];
                NSDate *alarmDate = [dformatter dateFromString:alarmDateString];
                NSDateComponents *nowComps = [calendar components: NSYearCalendarUnit | NSWeekOfYearCalendarUnit |
                                              NSWeekdayCalendarUnit |  NSHourCalendarUnit |
                                              NSMinuteCalendarUnit fromDate:alarmDate];
                
                NSString *strDay = [alarmDays objectAtIndex:indexday];
                
                int numDay = [strDay integerValue];
                
                if( numDay ) [nowComps setWeekday:numDay];
                
                else continue;
                
                //NSLog(@"hour: %ld minute: %ld", (long)nowComps.hour, (long)nowComps.minute);
                
                NSDate *fireDate = [calendar dateFromComponents:dateComps];
                NSDate *itemDate = [calendar dateFromComponents:nowComps];
                
                NSTimeInterval curInterval = [itemDate timeIntervalSinceDate:fireDate];
                
                //[dateComps setHour:nowComps.hour];
                //[dateComps setMinute:nowComps.minute];
                
                //NSLog(@"minInterval: %f curInterval: %f", minInterval, curInterval);
                
                if( curInterval > 0 )
                {
                    ret = true;
                    
                    if( minInterval <= 0 ) minInterval = 10 * 24 * 60 * 60;
                    
                    if( curInterval < minInterval )
                    {
                        minInterval = curInterval;
                        
                        nowMinDate = nowComps;
                        
                        targetAlarm = nowAlarm;
                        
                    }
                }
                
                else if( curInterval < 0 && !ret && curInterval < minInterval )
                {
                    minInterval = curInterval;
                    
                    nowMinDate = nowComps;
                    
                    targetAlarm = nowAlarm;
                }
            }
        }
    }
    
    UILocalNotification *localNoti = [[UILocalNotification alloc] init];
    
    if( localNoti == nil || targetAlarm == nil )  return ;
    
    localNoti.timeZone = [NSTimeZone defaultTimeZone];
    //localNoti.fireDate = [nowDate dateByAddingTimeInterval:-600];
    localNoti.fireDate = [calendar dateFromComponents:nowMinDate];
    /*
     要想看是怎么重复的，只要把时间设置为过去时间，打印出UILocalNotification的内容，他有一个非外部属性 next fire date
     看这个的值与fire date的值，一看就知道他们隔多长时间重复的。
     */
    localNoti.repeatInterval = NSWeekCalendarUnit;
    localNoti.alertBody = @"闹铃";
    localNoti.soundName = targetAlarm.music;
    
    NSNumber* uidToStore = [NSNumber numberWithInt:targetAlarm.alarm_id];
    NSDictionary *infoDict = [NSDictionary dictionaryWithObject:uidToStore forKey:@"AlarmID"];
    localNoti.userInfo = infoDict;
    
    localNoti.alertAction = @"进入app";
    localNoti.hasAction = NO;
    
    //[[UIApplication sharedApplication] scheduleLocalNotification:localNoti];
    
    //NSLog(@"LoclNotification: %@", localNoti);
    
    NSArray *localNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
    NSLog(@"%@", localNotifications);
    
    //[[UIApplication sharedApplication] cancelAllLocalNotifications];
}

- (void) cancelAlarmLocalNotification:(UILocalNotification *)localNoti
{
    [[UIApplication sharedApplication] cancelLocalNotification:localNoti];
}
/*
 有序，时间从早到晚
 */
- (void) orderAlarmClock
{
    //NSLog(@"order before: %@", self.dataContent);
    
    NSArray *tempArray = [self.dataContent sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = @"hh:mm aa";
        
        AlarmClock *tempAlarm1 = (AlarmClock *)obj1;
        NSString *dateString1 = [tempAlarm1.date stringByAppendingString:(tempAlarm1.am ? @" AM" : @" PM")];
        NSDate *date1 = [formatter dateFromString:dateString1];
        
        AlarmClock *tempAlarm2 = (AlarmClock *)obj2;
        NSString *dateString2 = [tempAlarm2.date stringByAppendingString:(tempAlarm2.am ? @" AM" : @" PM")];
        NSDate *date2 = [formatter dateFromString:dateString2];
        
        NSLog(@"date1 %@, date2 %@", dateString1, dateString2);
        
        return [date1 compare:date2];
    }];
    
    self.dataContent = [NSMutableArray arrayWithArray:tempArray];
    
    //NSLog(@"order after: %@", self.dataContent);
}

- (NSInteger) findAlarmClockLocal:(AlarmClock *)alarmClock
{
    // -1 表示不存在
    // 0-n 表示出现的位置
    int localIndex = -1;
    
    int arrayCount = [self.dataContent count];
    
    for( int index = 0; index < arrayCount; ++ index )
    {
        AlarmClock *tempClock = [self.dataContent objectAtIndex:index];
        
        if( tempClock.alarm_id == alarmClock.alarm_id )
        {
            localIndex = index;
            
            break;
        }
    }
    
    return localIndex;
}

@end
