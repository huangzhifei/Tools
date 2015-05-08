//
//  ClockDAO.h
//  FirstAll
//
//  Created by huangzhifei on 15-4-6.
//  Copyright (c) 2015年 huangzhifei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AlarmClock.h"
#import "DbManager.h"

#define CLOCKTABLE @"ClockTable"

@interface ClockDAO : NSObject
{
    DbManager *dbm;
}

@property (strong, nonatomic) NSMutableArray *listClockData;

//单例对象
- (id)init;

//创建表
- (BOOL) createTable;

//插入备忘录的方法
- (BOOL) create:(AlarmClock*)model;

//删除备忘录的方法
- (BOOL) remove:(AlarmClock*)model;

//修改备忘录的方法
- (BOOL) modify:(AlarmClock*)model;

- (NSMutableArray*) execSelectSql: (NSString *) sql;

//查询所有数据的方法
- (NSMutableArray*) findAll;

//获取当前数据库中的Max ID
- (int) currentMaxID;

//获得数据库中的数据量
- (int) dataCount;

@end
