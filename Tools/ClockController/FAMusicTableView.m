//
//  FAMusicTableView.m
//  FirstAll
//
//  Created by huangzhifei on 15-4-15.
//  Copyright (c) 2015年 huangzhifei. All rights reserved.
//

#import "FAMusicTableView.h"
#import "FAAlarmtableViewCell.h"

@implementation FAMusicTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if( self )
    {
        NSBundle *bundle = [NSBundle mainBundle];
        NSString *plistPath = [bundle pathForResource:@"AlarmMusic"
                                               ofType:@"plist"];
        //获取属性列表文件中的全部数据
        self.dataArray = [[NSArray alloc] initWithContentsOfFile:plistPath];
        
        self.sound = [AlarmSound sharedInstance];
    }
    
    return self;
}

+ (id) instanceView
{
    NSArray *nibView = [[NSBundle mainBundle] loadNibNamed:@"FAMusicTableView" owner:nil options:nil];
    
    return [nibView firstObject];
}

- (void) setAlarmClock:(AlarmClock *)alarmClock
{
    _alarmClock = alarmClock;
    
    for(int i = 0; i < [self.dataArray count]; ++ i)
    {
        NSDictionary *dict = [self.dataArray objectAtIndex:i];
        
        if( [[dict objectForKey:@"music"] isEqualToString:alarmClock.aliasMusic] )
        {
            self.lastPath = [NSIndexPath indexPathForRow:i inSection:0];
            
            break;
        }
    }
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"musicCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if( cell == nil )
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    
    
    NSDictionary *dict = [self.dataArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [dict objectForKey:@"name"];
    
    //要想tableview背景透明，要设置cell的背景
    cell.backgroundColor = [UIColor clearColor];
    
    //改变textColor来让其不受背景透明的影响
    cell.textLabel.textColor = [UIColor colorWithRed:(132*1.0/255) green:1 blue:(3*1.0/255) alpha:1];
    
    //无色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSInteger row = [indexPath row];
    
    NSInteger oldRow = [self.lastPath row];
    
    if (row == oldRow && self.lastPath != nil)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        cell.accessoryView.backgroundColor = [UIColor colorWithRed:(132*1.0/255) green:1 blue:(3*1.0/255) alpha:1];
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int newRow = [indexPath row];
    
    NSLog(@"newRow: %d", newRow);
    
    int oldRow = (self.lastPath != nil) ? [self.lastPath row] : -1;
    
    if (newRow != oldRow)
    {
        
        UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
        
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:self.lastPath];
        
        oldCell.accessoryType = UITableViewCellAccessoryNone;
        
        self.lastPath = indexPath;
        
        //要开始放音乐了
        
        //1、不管有没有音乐，先stop
        [self.sound stop];
        
        NSLog(@"1: %@", [self.dataArray objectAtIndex:newRow]);
        NSLog(@"2: %@", [[self.dataArray objectAtIndex:newRow] objectForKey:@"music"]);
        //2、播放
        __strong NSURL *avName = [[NSBundle mainBundle] URLForResource: [[self.dataArray objectAtIndex:newRow] objectForKey:@"music"]withExtension:nil];
        
        [self.sound play:avName];
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (IBAction)okClick:(id)sender
{
    [[KGModal sharedInstance] hideAnimated:YES];
    
    [self.sound stop];
    
    NSDictionary *dict = [self.dataArray objectAtIndex:self.lastPath.row];
    
    _alarmClock.music = [dict objectForKey:@"music"];
    _alarmClock.aliasMusic = [dict objectForKey:@"name"];
    
    NSLog(@"_alarmClock.music %@", _alarmClock.music);
    NSLog(@"_alarmClock.aliasMusic %@", _alarmClock.aliasMusic);
    
    [self udpateCellMusic];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"cell_changed" object:_alarmClock userInfo:nil];
    
}

- (IBAction)cancelClick:(id)sender
{
    [[KGModal sharedInstance] hideAnimated:YES];
    
    [self.sound stop];
}

- (void)registerCell:(FAAlarmTableViewCell *)cell
{
    _cell = cell;
}

- (void)udpateCellMusic
{
    if( _cell == nil ) return ;
    
    [_cell.alarmMusic setTitle:_alarmClock.aliasMusic forState:UIControlStateNormal];
    _cell.alarm.music = _alarmClock.music;
    _cell.alarm.aliasMusic = _alarmClock.aliasMusic;

}

@end
