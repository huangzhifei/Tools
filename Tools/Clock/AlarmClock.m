//
//  AlarmClock.m
//  FirstAll
//
//  Created by huangzhifei on 15-4-6.
//  Copyright (c) 2015年 huangzhifei. All rights reserved.
//

#import "AlarmClock.h"

@implementation AlarmClock

-(id) initWithValue
{
    self = [super init];
    
    if( self )
    {
        self.alarm_id = -1;
        self.am = 0;
        self.pm = 0;
        self.sun = 1;
        self.mon = 1;
        self.tue = 1;
        self.wed = 1;
        self.thu = 1;
        self.fri = 1;
        self.sat = 1;
        self.virbrate = 1;
        self.switchflag = 1;
        self.date = nil;
        self.music = @"Ocean Waves.m4a";
        self.aliasMusic = @"海浪声";
    }
    
    return self;
}
@end
