//
//  FADatePickerView.h
//  FirstAll
//
//  Created by huangzhifei on 15-4-13.
//  Copyright (c) 2015年 huangzhifei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KGModal.h"
#import "AlarmClock.h"

@class FAAlarmTableViewCell;

@interface FADatePickerView : UIView
{
    NSDateFormatter *dformatter;
    FAAlarmTableViewCell *_cell;
}

+(FADatePickerView*)instanceView;

@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) AlarmClock *alarmClock;

- (void)registerCell:(FAAlarmTableViewCell *) cell;

- (IBAction)okClick:(id)sender;

- (IBAction)cancelClick:(id)sender;

- (void) udpateCellDate;
@end
