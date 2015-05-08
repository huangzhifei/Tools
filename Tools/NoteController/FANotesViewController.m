//
//  FANotesViewController.m
//  FirstAll
//
//  Created by huangzhifei on 15-3-28.
//  Copyright (c) 2015年 huangzhifei. All rights reserved.
//

#import "FANotesViewController.h"

@interface FANotesViewController ()

@end

@implementation FANotesViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    noteDao = [[NoteDAO alloc] init];
    
//    self.tableView.backgroundColor = [UIColor clearColor];
//    
//    UIImage *image = [UIImage imageNamed:@"notebg.png"];
//    
//    self.view.layer.contents = (id) image.CGImage;

//    self.filterContent = [NSMutableArray arrayWithCapacity:[ noteDao dataCount ]];
//    
//    [NSTimer scheduledTimerWithTimeInterval:1.0
//                                     target:self
//                                   selector:@selector(loadTableViewData)
//                                   userInfo:nil
//                                    repeats:NO];
    
    //不重复，只调用一次。timer运行一次就会自动停止运行
    
    [self filterContentxForSearchText:@"" scope:-1];

    
}

- (void) loadTableViewData
{
    NSLog(@"loadTableViewData");
    
    [self filterContentxForSearchText:@"" scope:-1];
    
    int dataCount = [self.filterContent count];
    
    NSMutableArray *cell = [[NSMutableArray alloc] init];
    
    for(int index = 0; index < dataCount ; ++ index)
    {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        
        [cell addObject:indexPath];
        
    }
    
    [self.tableView insertRowsAtIndexPaths:cell withRowAnimation:UITableViewRowAnimationFade];
}

- (void) filterContentxForSearchText:(NSString *)searchText scope:(NSUInteger)scope
{
    //查询所有
    if( [searchText length] <= 0 )
    {
        //self.filterContent = self.dataContent;
        
        self.filterContent = [noteDao findAll];
    }
    //过滤
    else
    {
//        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@", searchText];
//        NSArray *tempArray = [self.dataContent filteredArrayUsingPredicate:predicate];
//        self.filterContent = [NSMutableArray arrayWithArray:tempArray];
        self.filterContent = [noteDao findByKey:searchText];
    }
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
    
    NSLog(@"new one date: %@", destDateString);
    
    return destDateString;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Search bar support

- (BOOL) searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    
    [self filterContentxForSearchText:searchString scope:self.searchBar.selectedScopeButtonIndex];
    
    return YES;
}

#pragma mark - Search bar support
//取消的时候要触发
- (void) searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    //NSLog(@"button cancel");
    //查询所有
    
    [self filterContentxForSearchText:@"" scope:-1];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    //return [[noteDao findAll] count];
    return [self.filterContent count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
        要注意cell == nil时他重新构造后的style要与最开始在设计器里面的一致，
        最开始我在设计器里面使用的是带有副标题的UITableViewCellStyleSubtitle
        但是在过滤后，我发现他不显示副标题了，就是上面的原因
     */
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NoteCell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:@"NoteCell"];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    //NSLog(@"indexPath: %@", [indexPath row]);[self filterContentxForSearchText:@"" scope:-1];
    
    Notes *note = [self.filterContent objectAtIndex:[indexPath row]];
    
//    if( [note.note_content length] > NoteNameLength )
//    {
//        note.note_content = [[note.note_content substringToIndex:22] stringByAppendingString:@"..."];
//    }
    
    cell.textLabel.text = note.note_name;
    
    cell.detailTextLabel.text = note.note_date;
    
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        Notes *deleteNote = [self.filterContent objectAtIndex:[indexPath row]];
        
        //源数组中删除
        [self.filterContent removeObjectAtIndex:[indexPath row]];
        
        //数据库中删除
        [noteDao remove:deleteNote];
        
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}



// Override to support rearranging the table view.
//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
//{
//    
//}
//
//
//// Override to support conditional rearranging of the table view.
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Return NO if you do not want the item to be re-orderable.
//    return NO;
//}


#pragma mark - Navigation

//对于没有搜索结果的tableView来说，这种使用storyboard建立的连续，确实简单与方便
//但是searchbar后，他显示的是search的tableView这是一个私有的view，我们没法在storyboard中创建连线
//故这样写，没法在search的结果集视图中跳转到detail页面，还是要使用didSelectRowAtIndexPath方法
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    if( [segue.identifier isEqualToString:@"showDetailView"] )
    {
        FADetailViewController *DetailView = segue.destinationViewController;
    
        NSIndexPath *indexPath = nil;
        
        if( [self.searchDisplayController isActive] )
        {
            indexPath = [ self.searchDisplayController.searchResultsTableView indexPathForSelectedRow ];
        }
        else
        {
            indexPath = [self.tableView indexPathForSelectedRow];
        }
        
        NSInteger sIndex = [ indexPath row];
        
        DetailView.cellNote = [self.filterContent objectAtIndex:sIndex];
        
        NSLog(@"cell");
    }
    
    else if( [segue.identifier isEqualToString:@"addNoteView"] )
    {
        NSLog(@"add");
        
        FADetailViewController *DetailView = segue.destinationViewController;
        
        Notes *newNote = [[Notes alloc] init];
        
        //获取当前时间
        NSDate *curDate = [NSDate date];
        
        newNote.note_date = [self stringFromDate:curDate];
        
        //获取当前数据库是Max id号
        newNote.note_id = [noteDao currentMaxID];
        
        DetailView.cellNote = newNote;

    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"ni");
    //需要判断是否为search tableview 才进行跳转
    if( tableView == self.searchDisplayController.searchResultsTableView )
    {
        [self performSegueWithIdentifier:@"showDetailView" sender:self];
    }
}

//要使用unwind不能直接使用navigation自带的back bar button要自己定义一个bar button
- (IBAction)unwindToNotesViewController:(UIStoryboardSegue*)segue
{
    
    FADetailViewController *detailViewController = segue.sourceViewController;
    
    BOOL isChanged = detailViewController.isChanged;
    
    NSLog(@"is change: %d", isChanged);

    if( isChanged == YES )
    {
        Notes *detailNote = detailViewController.cellNote;
        
        [self add4delNote:detailNote];
        
        detailViewController.isChanged = NO;
    }
}

- (void) add4delNote:(Notes *)newNote
{
    BOOL ret = NO;
    
    //用这种方式遍历后，增加的新元素始终在最后，这样update时的cell原先位置会变化
    //for ( Notes *loopNote in self.filterContent )
    int arrayCount = [self.filterContent count];
    for( int i = 0 ;i < arrayCount; ++ i)
    {
        Notes *loopNote = [self.filterContent objectAtIndex:i];
        if( loopNote.note_id == newNote.note_id )
        {
            ret = YES;
            
            //[self.filterContent removeObject:loopNote];
            
            [self.filterContent replaceObjectAtIndex:i withObject:newNote];
            
            break;
        }
    }
    
    //找到了，即原来就存在，更新数据库update和刷新tableview
    if( ret == YES )
    {
        [noteDao modify:newNote];
    }
    //新添加的，更新数据库insert和刷新tableview
    else
    {
        //最后添加
        //[self.filterContent addObject:newNote];
        
        //改成最近的显示在最开头
        [self.filterContent insertObject:newNote atIndex:0];
        
        [noteDao create:newNote];
    }

    [self.tableView reloadData];
}
@end
