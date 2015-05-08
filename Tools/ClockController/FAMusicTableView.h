//
//  FAMusicTableView.h
//  FirstAll
//
//  Created by huangzhifei on 15-4-15.
//  Copyright (c) 2015年 huangzhifei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KGModal.h"
#import "AlarmSound.h"
#import "AlarmClock.h"

@class FAAlarmTableViewCell;

@interface FAMusicTableView : UIView <UITableViewDataSource, UITableViewDelegate>
{
    FAAlarmTableViewCell *_cell;
}

@property (strong, nonatomic) IBOutlet UITableView *musicTableView;

@property (strong, nonatomic) NSArray *dataArray;

@property (strong ,nonatomic) NSIndexPath *lastPath;

@property (strong, nonatomic) AlarmSound *sound;

@property (assign, nonatomic) AlarmClock *alarmClock;

+(id) instanceView;

- (IBAction)okClick:(id)sender;

- (IBAction)cancelClick:(id)sender;

- (void)registerCell:(FAAlarmTableViewCell *) cell;

- (void) udpateCellMusic;

@end
