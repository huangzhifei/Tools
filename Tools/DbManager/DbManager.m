//
//  FADbManager.m
//  FirstAll
//
//  Created by huangzhifei on 15-3-28.
//  Copyright (c) 2015年 huangzhifei. All rights reserved.
//

#import "DbManager.h"

@implementation DbManager

- (id) init
{
    if ( self == [super init] )
    {
        db = nil;
    
        [self connectDb];
    }
    
    return self;
}

- (void) connectDb
{
    if( db )
    {
        return ;
    }
    
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *dbPath = [doc stringByAppendingPathComponent:DBNAME];
    
    //创建一个FMDatabase的对象
    db = [FMDatabase databaseWithPath:dbPath];
    
    //使用之前保证数据库是打开的
    if ([db open])
    {
        
    }
    else
    {
        //如果打开失败，则打印出错误信息
        NSLog(@"db open failed, path:%@, errorMsg:%@", dbPath, [db lastError]);
        
        [[FMDatabase alloc] close];
    }

}

- (BOOL) tableIsExsit:(NSString *)tableName
{
    if( !db )
    {
        return NO;
    }
    
    NSString *sql = [ NSString stringWithFormat: @"select count(*) as 'count' from sqlite_master where type ='table' and name = '%@'", tableName];
    
    FMResultSet *rs = [ self selectDataWithKey:@"" sql:sql];
    
    while ([rs next])
    {
        NSInteger count = [rs intForColumn:@"count"];
        
        NSLog(@"isTableOK %d", count);
        
        if (0 == count)
        {
            return NO;
        }
        else
        {
            return YES;
        }
    }
    
    return NO;
}

- (BOOL) createTable:(NSString *)sqlCommand
{
    if( !db )
    {
        return NO;
    }
    
    BOOL ret = [ db executeUpdate:sqlCommand ];
    
    NSLog(@"createTable :%d", ret);
    
    return ret;
}

- (BOOL) insertData:(NSString *)tableName sql:(NSString *)sqlCommand
{
    if( !db )
    {
        return NO;
    }
    
    BOOL ret = [ db executeUpdate:sqlCommand ];
    
    NSLog(@"insertData :%d", ret);
    
    return ret;
}

- (BOOL) updateData:(NSString *)tableName sql:(NSString *)sqlCommand
{
    if( !db )
    {
        return NO;
    }
    
    BOOL ret = [ db executeUpdate:sqlCommand ];
    
    NSLog(@"updateData %d", ret);
    
    return ret;
}

- (BOOL) deleteData:(NSString *)tableName sql:(NSString *)sqlCommand
{
    if( !db )
    {
        return NO;
    }
    
    BOOL ret = [ db executeUpdate:sqlCommand ];
    
    NSLog(@"deleteData %d", ret);
    
    return ret;
}

- (FMResultSet *) selectDataWithKey:(NSString *)tableName sql:(NSString *)sqlCommand
{
    if ( !db )
    {
        return nil;
    }
    
    FMResultSet *rs = [db executeQuery:sqlCommand];
    
    return rs;
}

@end
