//
//  DataDAO.h
//  FirstAll
//
//  Created by huangzhifei on 15-3-30.
//  Copyright (c) 2015年 huangzhifei. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DbManager.h"
#import "Notes.h"

#define NOTESTABLE @"NotesTable"

@interface NoteDAO : NSObject
{
    DbManager *dbm;
}

@property (strong, nonatomic) NSMutableArray *listNoteData;

//单例对象
- (id)init;

//创建表
- (BOOL) createTable;

//插入备忘录的方法
- (BOOL) create:(Notes*)model;

//删除备忘录的方法
- (BOOL) remove:(Notes*)model;

//修改备忘录的方法
- (BOOL) modify:(Notes*)model;

//查询所有数据的方法
- (NSMutableArray*) findAll;

- (NSMutableArray*) findByKey: (NSString *) stringKey;

- (NSMutableArray*) execSelectSql: (NSString *) sql;

//按照主键查询数据的方法
//-(Notes*) findById:(Notes*)model;

//获取当前数据库中的Max ID
- (int) currentMaxID;

//获得数据库中的数据量
- (int) dataCount;

//NSDate -> NSString
- (NSDate *)dateFromString:(NSString *)dateString;

//NSString -> NSDate
- (NSString *)stringFromDate:(NSDate *)date;

@end
