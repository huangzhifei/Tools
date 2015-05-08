//
//  FADatePickerView.m
//  FirstAll
//
//  Created by huangzhifei on 15-4-13.
//  Copyright (c) 2015年 huangzhifei. All rights reserved.
//

#import "FADatePickerView.h"
#import "FAAlarmTableViewCell.h"

@interface FADatePickerView()
{
    
}
@end

@implementation FADatePickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if( self )
    {
        dformatter = [[NSDateFormatter alloc]init];
        dformatter.dateFormat = @"hh:mm aa";
    }
    
    return  self;
}

+(FADatePickerView*) instanceView
{
    NSArray *nibView = [[NSBundle mainBundle] loadNibNamed:@"FADatePickerView" owner:nil options:nil];
    
    return [nibView firstObject];
}

- (void)setAlarmClock:(AlarmClock *)alarmClock
{
    //新建
    if( alarmClock.date == nil )
    {
        _alarmClock = alarmClock;
        self.datePicker.date = [NSDate date];
    }
    else
    {
        //这是已经新建完一个cell
        _alarmClock = alarmClock;
        NSString *dateString = [NSString stringWithFormat:@"%@ %@", alarmClock.date, alarmClock.am ? @"AM" : @"PM"];
        NSDate *date = [dformatter dateFromString:dateString];
        self.datePicker.date = date;
    }
}

- (IBAction)okClick:(id)sender
{
    [[KGModal sharedInstance] hideAnimated:YES];
    
    NSString *dateString = [dformatter stringFromDate:self.datePicker.date];
    
    if( [dateString hasSuffix:@"AM"] )
    {
        _alarmClock.am = 1;
        _alarmClock.pm = 0;
        _alarmClock.date = [dateString substringToIndex:[dateString length]-3];
    }
    else
    {
        _alarmClock.am = 0;
        _alarmClock.pm = 1;
        _alarmClock.date = [dateString substringToIndex:[dateString length]-3];
    }
    
    [self udpateCellDate];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"cell_changed" object:_alarmClock userInfo:nil];
}

- (void)registerCell:(FAAlarmTableViewCell *)cell
{
    _cell = cell;
}

- (void)udpateCellDate
{
    if( _cell == nil ) return ;
    
    [_cell.dateButton setTitle:_alarmClock.date forState:UIControlStateNormal];
    _cell.alarm.date = _alarmClock.date;

    _cell.amLabel.alpha = _alarmClock.am ? 1 : 0.2;
    _cell.pmLabel.alpha = _alarmClock.pm ? 1 : 0.2;
}

- (IBAction)cancelClick:(id)sender
{
    [[KGModal sharedInstance] hideAnimated:YES];
}

@end
