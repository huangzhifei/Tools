//
//  FAAlarmTableViewCell.h
//  FirstAll
//
//  Created by huangzhifei on 15-4-8.
//  Copyright (c) 2015年 huangzhifei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlarmClock.h"
#import "FADatePickerView.h"
#import "FAMusicTableView.h"

/*
 对于NSDate我特此来吐槽一下，相隔8小时时差不说，对于UIDatePicker里面获得的上下午时间，着实来区分呀
 NSDate to NSString 含有AM/PM 需要先使用格式  hh:mm aa 变成类似于 "11:40 AM" 然后对于
 NSString to NSDate "11:40 AM"变成NSDate 也需要这样格式，中间可能还莫名其妙的少8小时
 */
@interface FAAlarmTableViewCell : UITableViewCell

@property (strong, nonatomic) AlarmClock *alarm;

@property (strong, nonatomic) IBOutlet UIButton *dateButton;
- (IBAction)dateClick:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *alarmMusic;
- (IBAction)alarmClick:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *sunButton;
- (IBAction)sunClick:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *monButton;
- (IBAction)monClick:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *tueButton;
- (IBAction)tueClick:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *wedButton;
- (IBAction)wedClick:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *thuButton;
- (IBAction)thuClick:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *friButton;
- (IBAction)friClick:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *satButton;
- (IBAction)satClick:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *amLabel;

@property (strong, nonatomic) IBOutlet UILabel *pmLabel;

@property (strong, nonatomic) IBOutlet UIButton *vibrateButton;
- (IBAction)vibrateClick:(id)sender;

@property (strong, nonatomic) IBOutlet UISwitch *checkSwitch;

- (void) setUIOriginStatus;

- (void) changeStatus;

@end
