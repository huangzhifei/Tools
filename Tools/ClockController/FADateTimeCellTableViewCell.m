//
//  FADateTimeCellTableViewCell.m
//  FirstAll
//
//  Created by huangzhifei on 15-4-30.
//  Copyright (c) 2015年 huangzhifei. All rights reserved.
//

#import "FADateTimeCellTableViewCell.h"

@interface FADateTimeCellTableViewCell()
{
    
}

- (void) updateDateTime;

@end

@implementation FADateTimeCellTableViewCell


+ (id) instanceView
{
    NSArray *nibView = [[NSBundle mainBundle] loadNibNamed:@"FADateTimeCellTableViewCell" owner:nil options:nil];
    
    return [nibView firstObject];
}

- (void) startShowDate
{
    calendar = [NSCalendar autoupdatingCurrentCalendar];
    
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss aa"];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateDateTime) userInfo:nil repeats:YES];
}

- (void) updateDateTime
{
    NSDate *date = [NSDate date];
    
    NSDateComponents *dateComps = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit
                                   | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit
                                   | NSWeekdayCalendarUnit fromDate:date];
    
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    NSString *ampm = @"上午";
    if( [dateString hasSuffix:@"PM"] )
    {
        ampm = @"下午";
    }
    
    int hour = [dateComps hour];
    if( hour > 12 )
    {
        hour -= 12;
    }
    int minute = [dateComps minute];
    int second = [dateComps second];
    int month = [dateComps month];
    int day = [dateComps day];
    int weekday = [dateComps weekday];
    
    self.timeLable.textColor = [UIColor randomColor];
    self.timeLable.text = [NSString stringWithFormat:@"%d:%d:%d", hour, minute, second];
    self.zoneLabel.text = ampm;
    self.dateLabel.text = [NSString stringWithFormat:@"%d月%d日 %@", month, day,
                           [NSString weekDayFromNSInteger:weekday]];
    
    
}
@end
