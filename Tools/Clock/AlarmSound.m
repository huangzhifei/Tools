//
//  AlarmSound.m
//  FirstAll
//
//  Created by huangzhifei on 15-4-19.
//  Copyright (c) 2015年 huangzhifei. All rights reserved.
//

#import "AlarmSound.h"

@implementation AlarmSound

static AlarmSound *_instance = nil;

+(instancetype) sharedInstance
{
    if( _instance == nil )
    {
        _instance = [[AlarmSound alloc] init];
    }
    
    return _instance;
}

//- (id) init
//{
//    if( self == [super init] )
//    {
//        self.playing = NO;
//    }
//    
//    return self;
//}

- (void) play: (NSURL *)avName
{
    self.avPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:avName error:nil];
    
    if( !self.avPlayer ) return;
    
    self.avPlayer.volume = 1;
    
    //self.avPlayer.numberOfLoops = -1;
    
    [self.avPlayer play];
}

- (void) stop
{
    if( self.avPlayer )
    {
        [self.avPlayer stop];
        
        self.avPlayer = nil;
    }
}

@end
