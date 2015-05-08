//
//  FADbManager.h
//  FirstAll
//
//  Created by huangzhifei on 15-3-28.
//  Copyright (c) 2015年 huangzhifei. All rights reserved.
//

/*
 
 */
#import <Foundation/Foundation.h>

#import "FMDatabase.h"
#import "FMResultSet.h"

#define DBNAME @"DbSqlite3.sqlite"

@interface DbManager : NSObject
{
    FMDatabase *db;
}

- (id) init;

- (void) connectDb;

- (BOOL) createTable: (NSString *) sqlCommand;
- (BOOL) deleteData: (NSString *) tableName sql:(NSString *) sqlCommand;
- (BOOL) updateData: (NSString *) tableName sql:(NSString *) sqlCommand;
- (BOOL) insertData: (NSString *) tableName sql:(NSString *) sqlCommand;

- (FMResultSet *) selectDataWithKey: (NSString *) tableName sql:(NSString *) sqlCommand;

- (BOOL) tableIsExsit: (NSString *) tableName;

@end
