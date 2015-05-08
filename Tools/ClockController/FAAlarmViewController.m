//
//  FAAlarmViewController.m
//  FirstAll
//
//  Created by huangzhifei on 15-4-29.
//  Copyright (c) 2015年 huangzhifei. All rights reserved.
//

#import "FAAlarmViewController.h"

@interface FAAlarmViewController ()

@end

@implementation FAAlarmViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)stopAlarm:(id)sender
{
    [[AlarmSound sharedInstance] stop];
    
    [self dismissViewControllerAnimated:YES completion:nil]; 
}
@end
