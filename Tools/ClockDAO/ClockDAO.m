//
//  ClockDAO.m
//  FirstAll
//
//  Created by huangzhifei on 15-4-6.
//  Copyright (c) 2015年 huangzhifei. All rights reserved.
//

#import "ClockDAO.h"

@implementation ClockDAO

- (id) init
{
    if( self == [super init] )
    {
        dbm = [[ DbManager alloc ] init ];
        
        if( [dbm tableIsExsit:CLOCKTABLE] ==NO )
        {
            [self createTable];
        }
    }
    
    return self;
}

- (BOOL) createTable
{
    NSString *sql = [ NSString stringWithFormat: @"CREATE TABLE '%@' ('id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE, 'date' TEXT,'am' INTEGER, 'pm' INTEGER, 'sun' INTEGER, 'mon' INTEGER, 'tue' INTEGER, 'wed' INTEGER, 'thu' INTEGER, 'fri' INTEGER, 'sat' INTEGER, 'virbrate' INTEGER,  'music' TEXT, 'aliasmusic' TEXT, 'switch' INTEGER)", CLOCKTABLE];
    
    return [dbm createTable:sql];;
}

- (BOOL) create:(AlarmClock *)model
{
    
    NSString *sql = [ NSString stringWithFormat:@"insert into %@ (id, date, am, pm, sun, mon, tue, wed, thu, fri, sat, virbrate, music, aliasmusic, switch) values (%ld, '%@', %ld, %ld, %ld, %ld, %ld, %ld, %ld, %ld, %ld, %ld, '%@', '%@',%ld )",CLOCKTABLE, (long)model.alarm_id, model.date, (long)model.am, (long)model.pm, (long)model.sun, (long)model.mon, (long)model.tue, (long)model.wed, (long)model.thu, (long)model.fri, (long)model.sat, (long)model.virbrate, model.music,model.aliasMusic, (long)model.switchflag];
    
    NSLog(@"create sql: %@", sql);
    
    return [ dbm insertData:@"" sql:sql];
}

- (BOOL) remove:(AlarmClock *)model
{
    NSString *sql = [ NSString stringWithFormat:@"delete from %@ where id = %ld", CLOCKTABLE, (long)model.alarm_id];
    
    NSLog(@"remove sql: %@", sql);
    
    return [ dbm deleteData:@"" sql:sql];
}

- (BOOL) modify:(AlarmClock *)model
{
    NSString *sql = [ NSString stringWithFormat:@"update %@ set date = '%@', am = %ld, pm = %ld, sun = %ld, mon = %ld, tue = %ld, wed = %ld, thu = %ld, fri = %ld, sat = %ld, virbrate = %ld, music = '%@', aliasmusic = '%@', switch = %ld where id = %ld",CLOCKTABLE, model.date, (long)model.am, (long)model.pm, (long)model.sun, (long)model.mon, (long)model.tue,
                 (long)model.wed, (long)model.thu, (long)model.fri, (long)model.sat, (long)model.virbrate, model.music,
                  model.aliasMusic,(long)model.switchflag,(long)model.alarm_id];
    
    NSLog(@"modify sql: %@", sql);
    
    return [ dbm updateData:@"" sql:sql];
}

- (int)currentMaxID
{
    int curID = 0;
    
    NSString *sql = [NSString stringWithFormat:@"select max(id) from %@", CLOCKTABLE];
    
    FMResultSet *rs = [ dbm selectDataWithKey:@"" sql:sql];
    
    if ( [rs next] )
    {
        curID = [[ rs stringForColumnIndex:0 ] intValue];
    }
    
    return curID+1;
}

- (int)dataCount
{
    int dCount = 0;
    
    NSString *sql = [NSString stringWithFormat:@"select count(*) from %@", CLOCKTABLE];
    
    FMResultSet *rs = [ dbm selectDataWithKey:@"" sql:sql];
    
    if( [rs next] )
    {
        dCount = [[rs stringForColumnIndex:0]intValue];
    }
    
    return dCount;
}

- (NSMutableArray *)execSelectSql:(NSString *)sql
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    FMResultSet *rs = [ dbm selectDataWithKey:@"" sql:sql];
    
    while ( [rs next] )
    {
        //必须要每次重新定义一个，不然后面的addObject永远添加是最后一个内容
        AlarmClock *alarm = [[AlarmClock alloc]initWithValue];
        
        alarm.alarm_id = [[rs stringForColumnIndex:0] integerValue];
        alarm.date = [rs stringForColumnIndex:1];
        alarm.am = [[rs stringForColumnIndex:2] integerValue];
        alarm.pm = [[rs stringForColumnIndex:3] integerValue];
        alarm.sun = [[rs stringForColumnIndex:4] integerValue];
        alarm.mon = [[rs stringForColumnIndex:5] integerValue];
        alarm.tue = [[rs stringForColumnIndex:6] integerValue];
        alarm.wed = [[rs stringForColumnIndex:7] integerValue];
        alarm.thu = [[rs stringForColumnIndex:8] integerValue];
        alarm.fri = [[rs stringForColumnIndex:9] integerValue];
        alarm.sat = [[rs stringForColumnIndex:10] integerValue];
        alarm.virbrate = [[rs stringForColumnIndex:11] integerValue];
        alarm.music = [rs stringForColumnIndex:12];
        alarm.aliasMusic = [rs stringForColumnIndex:13];
        alarm.switchflag = [[rs stringForColumnIndex:14] integerValue];
        
        [result addObject:alarm];
    }
    
    return result;
    
}

- (NSMutableArray *) findAll
{
    NSString *sql = [ NSString stringWithFormat:@"select * from %@ order by id DESC", CLOCKTABLE ];
    
    return [self execSelectSql:sql];
}

@end
