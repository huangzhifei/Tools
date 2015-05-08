//
//  FAAlarmTableViewCell.m
//  FirstAll
//
//  Created by huangzhifei on 15-4-8.
//  Copyright (c) 2015年 huangzhifei. All rights reserved.
//

#import "FAAlarmTableViewCell.h"

@interface FAAlarmTableViewCell()

-(void) setStatusForSwitchClose: (BOOL) ret;
-(void) setNomalForSwitch;

@end

@implementation FAAlarmTableViewCell

#define CELLFADED  0.2
const  CGFloat UIFaded = 0.2000000;
const  CGFloat UIFaded_Close = 0.300000;
const  CGFloat OriginFaded = 1.000000;

- (void)awakeFromNib
{
    // Initialization code
    
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if( self )
    {
        //self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cellbg.jpg"]];
        
        //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(music4date:) name:@"change_music4date" object:nil];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//****注意了，这个事件的触发是事后的，意思是在UISwitch已经改变完状态后才触发的这个
//那么此时得到的值就是最新的值，并不需要我们去对他取反"!"操作
- (IBAction)switchClick:(id)sender
{
    UISwitch *contorl = (UISwitch *) sender;
    
    BOOL setting = contorl.isOn;
    
    [self.checkSwitch setOn:setting animated:YES];
    
    if( self.checkSwitch.isOn == NO )
    {
        [self setStatusForSwitchClose: NO];
    }
    else
    {
        [self setNomalForSwitch];
    }
    
    self.alarm.switchflag = (self.checkSwitch.isOn ? 1 : 0);
    
    NSLog(@"switchflag %ld", (long)self.alarm.switchflag);
    //这里要更新tableview，然后去更新数据库，使用“消息机制”
    [self changeStatus];
}

//这是设置switch关闭时的状态
-(void) setStatusForSwitchClose: (BOOL) ret
{
    self.amLabel.alpha = UIFaded_Close;
    self.pmLabel.alpha = UIFaded_Close;
    self.dateButton.alpha = UIFaded_Close;
    self.sunButton.alpha = UIFaded_Close;
    self.monButton.alpha = UIFaded_Close;
    self.tueButton.alpha = UIFaded_Close;
    self.wedButton.alpha = UIFaded_Close;
    self.thuButton.alpha = UIFaded_Close;
    self.friButton.alpha = UIFaded_Close;
    self.satButton.alpha = UIFaded_Close;
    self.vibrateButton.alpha = UIFaded_Close;
    self.alarmMusic.alpha = UIFaded_Close;
    //[self.checkSwitch setOn:self.alarm.switchflag animated:YES];
    [self.dateButton setTitle:self.alarm.date forState:UIControlStateNormal];
    [self.alarmMusic setTitle:self.alarm.aliasMusic forState:UIControlStateNormal];
}

//这是设置switch开着的状态
-(void) setNomalForSwitch
{
    self.amLabel.alpha = self.alarm.am ? OriginFaded : UIFaded;
    self.pmLabel.alpha = self.alarm.pm ? OriginFaded : UIFaded;
    [self.dateButton setTitle:self.alarm.date forState:UIControlStateNormal];
    self.dateButton.alpha = OriginFaded;
    self.sunButton.alpha = self.alarm.sun ? OriginFaded : UIFaded;
    self.monButton.alpha = self.alarm.mon ? OriginFaded : UIFaded;
    self.tueButton.alpha = self.alarm.tue ? OriginFaded : UIFaded;
    self.wedButton.alpha = self.alarm.wed ? OriginFaded : UIFaded;
    self.thuButton.alpha = self.alarm.thu ? OriginFaded : UIFaded;
    self.friButton.alpha = self.alarm.fri ? OriginFaded : UIFaded;
    self.satButton.alpha = self.alarm.sat ? OriginFaded : UIFaded;
    self.vibrateButton.alpha = self.alarm.virbrate ? OriginFaded : UIFaded;
    [self.alarmMusic setTitle:self.alarm.aliasMusic forState:UIControlStateNormal];
    self.alarmMusic.alpha = OriginFaded;
}

//
-(void) setUIOriginStatus
{
    [self.checkSwitch setOn:self.alarm.switchflag animated:YES];
    
    if( self.checkSwitch.isOn == NO )
    {
        [self setStatusForSwitchClose: NO];
        
        return ;
    }
    
    [self setNomalForSwitch];
}

//点击时间弹出框
- (IBAction)dateClick:(id)sender
{
    if ( self.checkSwitch.isOn == YES )
    {
        //更改时间
        FADatePickerView *datePickerView = [FADatePickerView instanceView];
        datePickerView.alarmClock = self.alarm;
        [datePickerView registerCell:self];
        KGModal *sharedInstance = [KGModal sharedInstance];
        sharedInstance.tapOutsideToDismiss = NO;
        sharedInstance.closeButtonType = KGModalCloseButtonTypeNone;
        [sharedInstance showWithContentView:datePickerView andAnimated:YES];
    }
}

//点击音乐弹出框
- (IBAction)alarmClick:(id)sender
{
    if( self.checkSwitch.isOn == YES )
    {
        //更改音乐
        FAMusicTableView *musicTableView = [FAMusicTableView instanceView];
        musicTableView.alarmClock = self.alarm;
        [musicTableView registerCell:self];
        KGModal *sharedInstance = [KGModal sharedInstance];
        sharedInstance.tapOutsideToDismiss = NO;
        sharedInstance.closeButtonType = KGModalCloseButtonTypeNone;
        [sharedInstance showWithContentView:musicTableView andAnimated:YES];
    }
}

//周日
- (IBAction)sunClick:(id)sender
{
    if ( self.checkSwitch.isOn == YES )
    {
        UIButton *btn = (UIButton *)sender;
    
        if( btn.alpha == UIFaded )
        {
            btn.alpha = OriginFaded;
            self.alarm.sun = 1;
        }
        else
        {
            btn.alpha = UIFaded;
            self.alarm.sun = 0;
        }
        
        [self changeStatus];
    }
}
//周一
- (IBAction)monClick:(id)sender
{
    if ( self.checkSwitch.isOn == YES )
    {
        UIButton *btn = (UIButton *)sender;
        
        if( btn.alpha == UIFaded )
        {
            btn.alpha = OriginFaded;
            self.alarm.mon = 1;
        }
        else
        {
            btn.alpha = UIFaded;
            self.alarm.mon = 0;
        }
        [self changeStatus];
    }
}
//周二
- (IBAction)tueClick:(id)sender
{
    if ( self.checkSwitch.isOn == YES )
    {
        UIButton *btn = (UIButton *)sender;
        
        if( btn.alpha == UIFaded )
        {
            btn.alpha = OriginFaded;
            self.alarm.tue = 1;
        }
        else
        {
            btn.alpha = UIFaded;
            self.alarm.tue = 0;
        }
        [self changeStatus];
    }

}
//周三
- (IBAction)wedClick:(id)sender
{
    if ( self.checkSwitch.isOn == YES )
    {
        UIButton *btn = (UIButton *)sender;
        
        if( btn.alpha == UIFaded )
        {
            btn.alpha = OriginFaded;
            self.alarm.wed = 1;
        }
        else
        {
            btn.alpha = UIFaded;
            self.alarm.wed = 0;
        }
        [self changeStatus];
    }

}
//周四
- (IBAction)thuClick:(id)sender
{
    if ( self.checkSwitch.isOn == YES )
    {
        UIButton *btn = (UIButton *)sender;
        
        if( btn.alpha == UIFaded )
        {
            btn.alpha = OriginFaded;
            self.alarm.thu = 1;
        }
        else
        {
            btn.alpha = UIFaded;
            self.alarm.thu = 0;
        }
        [self changeStatus];
    }

}
//周五
- (IBAction)friClick:(id)sender
{
    if ( self.checkSwitch.isOn == YES )
    {
        UIButton *btn = (UIButton *)sender;
        
        if( btn.alpha == UIFaded )
        {
            btn.alpha = OriginFaded;
            self.alarm.fri = 1;
        }
        else
        {
            btn.alpha = UIFaded;
            self.alarm.fri = 0;
        }
        [self changeStatus];
    }

}
//周六
- (IBAction)satClick:(id)sender
{
    if ( self.checkSwitch.isOn == YES )
    {
        UIButton *btn = (UIButton *)sender;
        
        if( btn.alpha == UIFaded )
        {
            btn.alpha = OriginFaded;
            self.alarm.sat = 1;
        }
        else
        {
            btn.alpha = UIFaded;
            self.alarm.sat = 0;
        }
        [self changeStatus];
    }
}
//振动
- (IBAction)vibrateClick:(id)sender
{
    if ( self.checkSwitch.isOn == YES )
    {
        UIButton *btn = (UIButton *)sender;
        
        if( btn.alpha == UIFaded )
        {
            btn.alpha = OriginFaded;
            self.alarm.virbrate = 1;
        }
        else
        {
            btn.alpha = UIFaded;
            self.alarm.virbrate = 0;
        }
        [self changeStatus];
    }

}

//改变状态时发送“消息机制”
- (void)changeStatus
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"cell_changed" object:self.alarm userInfo:nil];
}

@end
