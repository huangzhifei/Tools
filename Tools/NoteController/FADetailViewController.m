//
//  FADetailViewController.m
//  FirstAll
//
//  Created by huangzhifei on 15-3-29.
//  Copyright (c) 2015年 huangzhifei. All rights reserved.
//

#import "FADetailViewController.h"

@interface FADetailViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@end

@implementation FADetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"3:");
    
    self.timeLabel.text = self.cellNote.note_date;
    
    self.contentView.text = self.cellNote.note_content;
    
}

- (NSDate *)dateFromString:(NSString *)dateString
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat: @"yy-MM-dd HH:mm"];
    
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    
    return destDate;
    
}

- (NSString *)stringFromDate:(NSDate *)date
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息 +0000。
    
    [dateFormatter setDateFormat:@"yy-MM-dd HH:mm"];
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if( sender != self.saveButton )
    {
        return ;
    }
    
    [self doneSave];
}


- (void)doneSave
{
    self.cellNote.note_content = self.contentView.text;
    
    NSString *tempName = self.contentView.text;
    
    if( [self.cellNote.note_content length] > NoteNameLength )
    {
        self.cellNote.note_name = [[self.cellNote.note_content substringToIndex:(NoteNameLength-3)]
                                   stringByAppendingString:@"..."];
    }
    
    self.cellNote.note_name = tempName;
    
    self.isChanged = YES;
}


@end
