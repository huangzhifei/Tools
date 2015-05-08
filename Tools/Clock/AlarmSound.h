//
//  AlarmSound.h
//  FirstAll
//
//  Created by huangzhifei on 15-4-19.
//  Copyright (c) 2015年 huangzhifei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface AlarmSound : NSObject

@property (strong, nonatomic) AVAudioPlayer *avPlayer;
//@property (assign, nonatomic) BOOL playing;

+ (instancetype) sharedInstance;

- (void) play: (NSURL *) avName;
- (void) stop;

@end
