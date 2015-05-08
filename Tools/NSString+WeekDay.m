//
//  NSString+WeekDay.m
//  FirstAll
//
//  Created by huangzhifei on 15-4-30.
//  Copyright (c) 2015年 huangzhifei. All rights reserved.
//

#import "NSString+WeekDay.h"

@implementation NSString (WeekDay)

+ (NSString *) weekDayFromNSInteger: (NSInteger) num
{
    NSString *weekString = @"";
    switch (num)
    {
        case 1:
            
            weekString = @"星期日";
            
            break;
        case 2:
            weekString = @"星期一";
            break;
            
        case 3:
            weekString = @"星期二";
            break;
            
        case 4:
            weekString = @"星期三";
            break;
            
        case 5:
            weekString = @"星期四";
            break;
            
        case 6:
            weekString = @"星期五";
            break;
            
        case 7:
            weekString = @"星期六";
            break;
            
        default:
            break;
    }
    
    return  weekString;
}
@end
