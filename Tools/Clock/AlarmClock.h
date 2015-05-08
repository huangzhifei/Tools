//
//  AlarmClock.h
//  FirstAll
//
//  Created by huangzhifei on 15-4-6.
//  Copyright (c) 2015年 huangzhifei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlarmClock : NSObject

-(id)initWithValue;

@property (nonatomic, assign) NSInteger alarm_id;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, assign) NSInteger am;
@property (nonatomic, assign) NSInteger pm;
@property (nonatomic, assign) NSInteger sun;
@property (nonatomic, assign) NSInteger mon;
@property (nonatomic, assign) NSInteger tue;
@property (nonatomic, assign) NSInteger wed;
@property (nonatomic, assign) NSInteger thu;
@property (nonatomic, assign) NSInteger fri;
@property (nonatomic, assign) NSInteger sat;
@property (nonatomic, assign) NSInteger virbrate;
@property (nonatomic, strong) NSString *music;
@property (nonatomic, strong) NSString *aliasMusic;
@property (nonatomic, assign) NSInteger switchflag;


/*
 下面是上面的影子，下面值表示switch关闭时的状态
 */


@end
