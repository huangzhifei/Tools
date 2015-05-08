//
//  FAAlarmTableViewController.m
//  FirstAll
//
//  Created by huangzhifei on 15-4-6.
//  Copyright (c) 2015年 huangzhifei. All rights reserved.
//

#import "FAAlarmTableViewController.h"

@interface FAAlarmTableViewController ()

- (void) updateData: (NSNotification*) notify;

@end

@implementation FAAlarmTableViewController

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
    
    //必须要先把tableview的背景颜色置成clearColor，不然下面的添加背景图片没有效果
    self.tableView.backgroundColor = [UIColor clearColor];
    
    //设置背景图片，图片为纯黑色，这是因为tableview在滚动时背景为白色
    //UIImage *image = [UIImage imageNamed:@"wheat.png"];
    //self.view.layer.contents = (id)image.CGImage;

    //隐藏多余的分割线
    [self setExtraCellHidden:self.tableView];
    
    clockDao = [[ClockDAO alloc]init];
    
    alarmManager = [AlarmClockManager sharedInstance];
    
    alarmManager.dataContent = [clockDao findAll];
    
    //[alarmManager orderAlarmClock];
    
    //注册“消息机制”
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateData:)
                                                 name:@"cell_changed" object:nil];
    
}

- (void) updateData:(NSNotification *)notify
{
    AlarmClock *tempAlarm = [notify object];

    [self add4updateAlarm:tempAlarm];
}

- (void) add4updateAlarm:(AlarmClock *)alarmClock
{
    int index = [alarmManager findAlarmClockLocal:alarmClock];
    
    NSLog(@"index: %d", index);
    
    //局部刷新
    NSIndexPath *indexPath = nil;
    
    //add
    if( index == -1 )
    {
        indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        
        [alarmManager.dataContent insertObject:alarmClock atIndex:0];
        
        [clockDao create:alarmClock];
        
        //这是新添加后的局部刷新方式
        [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationRight];

    }
    //udpate
    else
    {
        indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        
        [alarmManager.dataContent replaceObjectAtIndex:index withObject:alarmClock];
        
        [clockDao modify:alarmClock];
        
        //这是原来界面上存在的局部刷新方式
//        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
        
        //没必要刷新了，只要更新数据库，cell上面内容自己已经变化了
        
        //[[NSNotificationCenter defaultCenter] postNotificationName:@"change_music4date" object:alarmClock userInfo:nil];
    }
}

- (AlarmClock *) newAlarmClock
{
    AlarmClock *tempClock = [[AlarmClock alloc] initWithValue];
    
    tempClock.alarm_id = [clockDao currentMaxID];
    
    return tempClock;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [alarmManager.dataContent count];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *identify = @"AlarmCell";
    
    FAAlarmTableViewCell * cell = (FAAlarmTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    
    if( cell == nil )
    {
        //麻的，这里的NibName为xib的名字，我TM一直以为是什么ID，一直报错说找不到这个xib，fuck you
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FAAlarmTableViewCell" owner:nil
                                                   options:nil];
        
        cell = [nib objectAtIndex:0];
    }
    
    cell.alarm = [alarmManager.dataContent objectAtIndex:indexPath.row];
    
    [cell setUIOriginStatus];
    
    return cell;
    
}

/*
 隐藏多余的分割线，这样的好处是cell比较少的，不会显示过多的分割线，并且在自定义的cell中，如果删除最后一个
 cell的时候，会卡顿一下，然后很多分割线把cell分割了，体验特别差。
*/
- (void) setExtraCellHidden:(UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return cell.frame.size.height;
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        AlarmClock *deleteClock = [alarmManager.dataContent objectAtIndex:[indexPath row]];
        
        //源数组中删除
        [alarmManager.dataContent removeObjectAtIndex:[indexPath row]];
        
        // 局部刷新
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        //数据库中删除
        [clockDao remove:deleteClock];
        
    }

}

@end
