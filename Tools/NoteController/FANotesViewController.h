//
//  FANotesViewController.h
//  FirstAll
//
//  Created by huangzhifei on 15-3-28.
//  Copyright (c) 2015年 huangzhifei. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FADetailViewController.h"
#import "NoteDAO.h"
#import "Notes.h"
#import "FADefine.h"

@interface FANotesViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate, UISearchBarDelegate>
{
    NoteDAO *noteDao;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

//原始数据集
@property (strong, nonatomic) NSMutableArray *dataContent;

//过滤数据集
@property (strong, nonatomic) NSMutableArray *filterContent;


/*
 功能：过滤search的结果集
 searchText：过滤关键字
 scope：过滤范围
 */
- (void) filterContentxForSearchText: (NSString *) searchText scope:(NSUInteger)scope;

//NSDate -> NSString
- (NSDate *)dateFromString:(NSString *)dateString;

//NSString -> NSDate
- (NSString *)stringFromDate:(NSDate *)date;

- (void) add4delNote: (Notes *)newNote;

- (void)loadTableViewData;

@end
