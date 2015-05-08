//
//  FAAlarmTableViewController.h
//  FirstAll
//
//  Created by huangzhifei on 15-4-6.
//  Copyright (c) 2015年 huangzhifei. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FAAlarmTableViewCell.h"
#import "AlarmClock.h"
#import "ClockDAO.h"
#import "AlarmClockManager.h"
#import "FADateTimeCellTableViewCell.h"

/*
 以后界面的任何更新，都不像现在这样麻烦了，直接改变cell的状态后，更新数据库及更新tableview中的dataArray
 并且都不用重新刷新tableview，当然删除和插入需要，其他的都不需要，因为cell上已经改变了状态
 这个在第二迭代中更改，第二次迭代还要修改note中的背景及完善note中从编辑状态到隐藏编辑状态，使用自定义的datepicker
 来替换现在的，因为官方的datepicker无法更改里面的字体颜色，从而没法做到背景透明
 */
@interface FAAlarmTableViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    ClockDAO *clockDao;
    
    AlarmClockManager *alarmManager;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

//原始数据集
//@property (strong, nonatomic) NSMutableArray *dataContent;

//- (void) addFromClockViewControllerNewDate: (NSString *) newDate;

//- (void) addFromClockVIewCOntrollerUpdateDate: (NSArray *) updateDate;

//- (void) addFromClockViewControllerUpdateMusic:(NSArray *)udpateMusic;

//- (NSArray *) findAlarmClock:(NSInteger) alarm_id;

- (void) add4updateAlarm: (AlarmClock *) alarmClock;

- (AlarmClock *) newAlarmClock;

@end
