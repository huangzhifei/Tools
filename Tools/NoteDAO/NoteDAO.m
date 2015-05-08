//
//  DataDAO.m
//  FirstAll
//
//  Created by huangzhifei on 15-3-30.
//  Copyright (c) 2015年 huangzhifei. All rights reserved.
//

#import "NoteDAO.h"

@implementation NoteDAO

//static NoteDAO *sharedManagerInstance = nil;
//
//+ (NoteDAO*) sharedManager
//{
//    static dispatch_once_t once;
//    
//    dispatch_once(&once, ^{
//       
//        sharedManagerInstance = [[self alloc] init];
//        
//        sharedManagerInstance.listNoteData = [[NSMutableArray alloc] init];
//        
//        
//    });
//    
//    return sharedManagerInstance;
//}

- (id) init
{
    if( self == [super init] )
    {
        dbm = [[ DbManager alloc ] init ];
        
        if( [dbm tableIsExsit:NOTESTABLE] ==NO )
        {
            [self createTable];
        }
    }
    
    return self;
}

- (BOOL) createTable
{
    NSString *sql = [ NSString stringWithFormat: @"CREATE TABLE '%@' ('id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE,   \
                     'name' TEXT, 'content' TEXT,'date' DATE)", NOTESTABLE];
    
    return [dbm createTable:sql];;
}

- (BOOL) create:(Notes *)model
{
    
    NSString *sql = [ NSString stringWithFormat:@"insert into %@ (id, name, content, date) values (%ld, '%@', '%@', '%@')",
                     NOTESTABLE, (long)model.note_id, model.note_name, model.note_content, model.note_date];
    
    NSLog(@"create sql: %@", sql);
    
    
    return [ dbm insertData:@"" sql:sql];
}

- (BOOL) remove:(Notes *)model
{
    NSString *sql = [ NSString stringWithFormat:@"delete from %@ where id = %ld", NOTESTABLE, (long)model.note_id];
    
    NSLog(@"remove sql: %@", sql);
    
    return [ dbm deleteData:@"" sql:sql];
}

- (BOOL) modify:(Notes *)model
{
    NSString *sql = [ NSString stringWithFormat:@"update %@ set name = '%@', content = '%@', date = '%@' where id = %ld",
                     NOTESTABLE, model.note_name, model.note_content, model.note_date, (long)model.note_id];
    
    NSLog(@"modify sql: %@", sql);
    
    return [ dbm updateData:@"" sql:sql];
}

- (NSMutableArray *) findAll
{
    NSString *sql = [ NSString stringWithFormat:@"select * from %@ order by id DESC", NOTESTABLE ];
    
    return [self execSelectSql:sql];
}

- (NSMutableArray *)findByKey:(NSString *)stringKey
{
    
    NSString *sql = [ NSString stringWithFormat:@"select * from %@ where name like '%%%@%%' order by id DESC;", NOTESTABLE, stringKey ];
    
    NSLog(@"findByKey sql: %@", sql);
    
    return [self execSelectSql:sql];
}

- (int)currentMaxID
{
    int curID = 0;
    
    NSString *sql = [NSString stringWithFormat:@"select max(id) from %@", NOTESTABLE];
    
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
    
    NSString *sql = [NSString stringWithFormat:@"select count(*) from %@", NOTESTABLE];
    
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
        Notes *note = [[Notes alloc]init];
        note.note_id = [[rs stringForColumnIndex:0] integerValue];
        note.note_name = [rs stringForColumnIndex:1];
        note.note_content = [rs stringForColumnIndex:2];
        note.note_date = [rs stringForColumnIndex:3];
        [result addObject:note];
    }
    
    return result;

}

- (NSDate *)dateFromString:(NSString *)dateString
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat: @"yy-MM-dd HH:mm"];
    
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    
    return destDate;
    
}

- (NSString *)stringFromDate:(NSDate *)date
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息 +0000。
    
    [dateFormatter setDateFormat:@"yy-MM-dd HH:mm"];
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
    
}

@end
