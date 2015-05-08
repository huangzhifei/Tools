//
//  FAClockViewController.m
//  FirstAll
//
//  Created by huangzhifei on 15-4-6.
//  Copyright (c) 2015年 huangzhifei. All rights reserved.
//

#import "FAClockViewController.h"

@interface FAClockViewController ()
{
    NSString *add_alarm_notify;
    NSString *update_time_notify;
    NSString *update_ring_notify;
    NSString *update_music_notify;
}


@end

@implementation FAClockViewController

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
    
    add_alarm_notify = @"add_alarm_notify";
    
    update_time_notify = @"update_time_notify";
    
    update_ring_notify = @"update_ring_notify";
    
    update_music_notify = @"update_music_notify";
    
    self.bgArray = [NSArray arrayWithObjects:@"beach.png",@"canal.png",@"chalkboard.png",@"drops.png",
                    @"rainbow.png",@"trees.png",@"wheat.png", nil];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    UIImage *image = [UIImage imageNamed:[self.bgArray objectAtIndex:6]];
    
    self.view.layer.contents = (id)image.CGImage;
    
    CGRect frame = [UIScreen mainScreen].applicationFrame;
    
    frame.origin.y = self.navigationController.navigationBar.frame.size.height + 20;
    
    frame.size.height -= (29 + frame.origin.y);
    
    self.stopWatchView = [[FAStopWatchViewController alloc] init];
    self.stopWatchView.view.frame = frame;

    self.timerView = [[FATimerViewController alloc] init];
    self.timerView.view.frame = frame;
    
    [self.view addSubview:self.alarmView.view];
    [self.view addSubview:self.showClock];
    
    self.cacheView = [[NSMutableDictionary alloc] init];
    
    self.showClock = [FAShowClock instanceView];
    [self.showClock startShowDate];
    self.showClock.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width,
                                      self.showClock.frame.size.height);
    [self.view addSubview:self.showClock];
    
    self.alarmView = [[FAAlarmTableViewController alloc] init];
    self.alarmView.view.frame = CGRectMake(frame.origin.x, frame.origin.y + self.showClock.frame.size.height, frame.size.width, frame.size.height);
    
    //把xib里面的view设置成取消autosize了，不然没法适配所有尺寸的机型，tableview始终无法显无全最后一行cell
    //这个问题纠结了太久了
    self.alarmView.tableView.frame = CGRectMake(-15, 0, frame.size.width+20, frame.size.height - self.showClock.frame.size.height - 3);
    //NSLog(@"###%f", frame.size.height);

    [self.view addSubview:self.alarmView.view];
    
    subViewCount = [[self.view subviews] count];
    
    [self.cacheView setObject:self.alarmView.view forKey:[NSString stringWithFormat:@"%d",ALARMVIEW]];
    [self.cacheView setObject:self.stopWatchView.view forKey:[NSString stringWithFormat:@"%d",STOPWATCHVIEW]];
    [self.cacheView setObject:self.timerView.view forKey:[NSString stringWithFormat:@"%d",TIMERVIEW]];

    self.segCotroller.selectedSegmentIndex = 0;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(newAlarmModel)];
    
    //[NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(udpateBg) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void) udpateBg
{
    int randIndex = random() % [self.bgArray count];
    
    UIImage *image = [UIImage imageNamed:[self.bgArray objectAtIndex:randIndex]];
    
    self.view.layer.contents = (id)image.CGImage;
}

- (IBAction)switchView:(id)sender
{
    //准备动画
    [UIView beginAnimations:@"animationID" context:nil];
    
    //动画播放持续时间
    [UIView setAnimationDuration:0.5f];
    
    //动画速度
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    [UIView setAnimationRepeatAutoreverses:NO];
    
    NSString *indexKey = [ NSString stringWithFormat:@"%ld", (long)[sender selectedSegmentIndex]];

    NSArray *viewArray = [self.view subviews];
    
    if( [viewArray count] == subViewCount )
    {
        [[viewArray objectAtIndex:subViewCount-1] removeFromSuperview];
    }
    
    //动画方向
    switch ([sender selectedSegmentIndex])
    {
        case ALARMVIEW:
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(newAlarmModel)];

            
            break;
        
        case STOPWATCHVIEW:
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
            self.navigationItem.rightBarButtonItem = nil;
            
            break;
            
        case TIMERVIEW:
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
            self.navigationItem.rightBarButtonItem = nil;
            
            break;
            
        default:
            break;
    }
    
    [self.view exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
    
    [UIView commitAnimations];
    
    [self.view addSubview:[self.cacheView objectForKey:indexKey]];
}

- (void) newAlarmModel
{
    NSLog(@"new one");

    FADatePickerView *cview = [FADatePickerView instanceView];
    KGModal *sharedInstance = [KGModal sharedInstance];
    cview.alarmClock = [self.alarmView newAlarmClock];
    [cview registerCell:nil];
    sharedInstance.tapOutsideToDismiss = NO;
    sharedInstance.closeButtonType = KGModalCloseButtonTypeNone;
    [sharedInstance showWithContentView:cview andAnimated:YES];
}

@end
