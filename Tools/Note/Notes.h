//
//  Notes.h
//  FirstAll
//
//  Created by huangzhifei on 15-3-30.
//  Copyright (c) 2015年 huangzhifei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Notes : NSObject

@property (assign, nonatomic) NSInteger note_id;
@property (strong, nonatomic) NSString *note_name;
@property (strong, nonatomic) NSString *note_content;
@property (strong, nonatomic) NSString *note_date;

@end
