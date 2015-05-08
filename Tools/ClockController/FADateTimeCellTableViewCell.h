//
//  FADateTimeCellTableViewCell.h
//  FirstAll
//
//  Created by huangzhifei on 15-4-30.
//  Copyright (c) 2015年 huangzhifei. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIColor+Random.h"
#import "NSString+WeekDay.h"

@interface FADateTimeCellTableViewCell : UITableViewCell
{
    NSCalendar *calendar;
    NSDateFormatter *dateFormatter;
}

@property (strong, nonatomic) IBOutlet UILabel *timeLable;
@property (strong, nonatomic) IBOutlet UILabel *zoneLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;


+ (instancetype) instanceView;

- (void) startShowDate;


@end
