//
//  FAClockViewController.h
//  FirstAll
//
//  Created by huangzhifei on 15-4-6.
//  Copyright (c) 2015年 huangzhifei. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FAAlarmTableViewController.h"
#import "FAStopWatchViewController.h"
#import "FATimerViewController.h"
#import "KGModal.h"
#import "FADatePickerView.h"
#import "FAShowClock.h"

#define ALARMVIEW 0
#define STOPWATCHVIEW 1
#define TIMERVIEW 2

@interface FAClockViewController : UIViewController
{
    int subViewCount;
}

@property (strong, nonatomic) NSMutableDictionary *cacheView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segCotroller;

@property(strong, nonatomic) FAAlarmTableViewController *alarmView;
@property(strong, nonatomic) FAStopWatchViewController *stopWatchView;
@property(strong, nonatomic) FATimerViewController *timerView;
@property(strong, nonatomic) FAShowClock *showClock;
@property(strong, nonatomic) NSArray *bgArray;

- (void) newAlarmModel;

//- (void) addNotification: (NSString *) notifyName;

//- (void) removeNotification: (NSString *) notifyName;

- (IBAction)switchView:(id)sender;

@end
