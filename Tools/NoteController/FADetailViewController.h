//
//  FADetailViewController.h
//  FirstAll
//
//  Created by huangzhifei on 15-3-29.
//  Copyright (c) 2015年 huangzhifei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Notes.h"
#import "FADefine.h"
@interface FADetailViewController : UIViewController


@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentView;

@property (weak, nonatomic) NSString *cellText;
@property (weak, nonatomic) NSString *cellTime;

@property (strong, nonatomic) Notes *cellNote;
@property (assign, nonatomic) BOOL isChanged;

//NSDate -> NSString
- (NSDate *)dateFromString:(NSString *)dateString;

//NSString -> NSDate
- (NSString *)stringFromDate:(NSDate *)date;

- (void)doneSave;

@end
