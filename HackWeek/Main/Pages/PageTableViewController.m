//
//  PageTableViewController.m
//  HackWeek
//
//  Created by New on 2020/7/29.
//  Copyright © 2020 Godlowd. All rights reserved.
//

#import "PageTableViewController.h"
#import "PageTableViewCell.h"
#import <Masonry.h>
#import <AFNetworking.h>
#import "UserInfo.h"
#import "PageDetailViewController.h"
#import "PostTableViewController.h"
@interface PageTableViewController ()

@end

@implementation PageTableViewController

NSString *pageCell = @"pageCell";

-(void)viewWillAppear:(BOOL)animated{
    self.pages = NSMutableArray.new;
    [self fetchPage];
    NSLog(@"the dict is %@", self.pages);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:false];

    self.view.backgroundColor = UIColor.yellowColor;
    [self containerInit];
    [self headerViewInit];
    [self tableViewInit];

    
    [self.pageView registerClass:PageTableViewCell.class forCellReuseIdentifier:pageCell];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)fetchPage{
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.completionQueue = dispatch_get_global_queue(0, DISPATCH_QUEUE_PRIORITY_DEFAULT);
    [manager.requestSerializer setValue: [NSString stringWithFormat:@"Bearer %@", [UserInfo shareInstance].token] forHTTPHeaderField:@"Authorization"];
//    dispatch_queue_t queue = dispatch_get_global_queue(0, DISPATCH_QUEUE_PRIORITY_HIGH);
    [manager GET:@"http://s1.996404.xyz:3000/api/v1/post" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求所有帖子成功");
        for (NSDictionary *dict in [[responseObject valueForKey:@"data"] valueForKey:@"posts_info"]) {
            [self.pages addObject:dict];
        }
        dispatch_semaphore_signal(semaphore);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败--%@",error);
        dispatch_semaphore_signal(semaphore);
    }];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
}

#pragma mark - PostPage
-(void)postPage{
    PostTableViewController *controller = PostTableViewController.new;
    controller.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:controller animated:YES completion:nil];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.pageView deselectRowAtIndexPath:indexPath animated:YES];
    PageDetailViewController *controller = PageDetailViewController.new;
    NSDictionary *dict = _pages[indexPath.row];
    controller.pageId = [dict valueForKey:@"_id"];
    controller.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:controller animated:YES completion:nil];
//    [self.navigationController pushViewController:controller animated:YES];
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.pages.count;
}
# pragma mark Init
-(void)containerInit{
    _container = [[UIView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    [self.view addSubview:_container];
    [_container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

-(void)tableViewInit{
    _pageView = UITableView.new;
    [self.container addSubview:_pageView];
    [_pageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.container);
        make.top.equalTo(self.header.mas_bottom);
        make.bottom.equalTo(self.container.mas_bottom);
    }];
    self.pageView.delegate = self;
    self.pageView.dataSource = self;
    self.pageView.rowHeight = UITableViewAutomaticDimension;
}

-(void)headerViewInit{
    _header = [[UIView alloc] init];
    _header.backgroundColor = UIColor.whiteColor;
    [self.container addSubview:_header];
    [_header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.height.mas_equalTo(137);
        make.top.equalTo(self.view);
    }];
    _header.backgroundColor = [self colorWithHexString:@"435b5c"];
    
    UILabel *title = UILabel.new;
    title.text = @"1037号树洞";
    title.font = [UIFont systemFontOfSize:30];
    [_header addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_header);
        make.top.equalTo(_header.mas_top).with.offset(50);
        make.height.mas_equalTo(30);
        make.bottom.equalTo(_header).with.offset(-28);
    }];
    
    UIButton *newPage = [UIButton buttonWithType:UIButtonTypeCustom];
    newPage.frame = CGRectMake(0, 0, 26, 26);
    [newPage setBackgroundImage:[UIImage imageNamed:@"发布"] forState:UIControlStateNormal];
    [_header addSubview:newPage];
    [newPage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_header.mas_right).with.offset(-53);
        make.centerY.equalTo(title);
    }];
    [newPage addTarget:self action:@selector(postPage) forControlEvents:UIControlEventTouchUpInside];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:pageCell forIndexPath:indexPath];
    
    for (UIView *subview in cell.subviews) {
        [subview removeFromSuperview];
    }
    NSDictionary *dict = _pages[indexPath.row];
    [cell initAvatarTitleContentTime];
    cell.title.text = [dict valueForKey:@"title"];
    cell.content.text = [dict valueForKey:@"content"];
    cell.time.text = [self getDateStringWithTimeStr:[dict valueForKey:@"updated_at"]];
    return cell;
}

// 时间戳转时间,时间戳为13位是精确到毫秒的，10位精确到秒
- (NSString *)getDateStringWithTimeStr:(NSString *)str{
    NSTimeInterval time=[str doubleValue]/1000;//传入的时间戳str如果是精确到毫秒的记得要/1000
    NSDate *detailDate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; //实例化一个NSDateFormatter对象
    //设定时间格式,这里可以设置成自己需要的格式
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss SS"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detailDate];
    return currentDateStr;
}

# pragma mark set Color
-(UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];

    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];

    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];

    if ([cString length] != 6) return  [UIColor grayColor];

    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];

    range.location = 2;
    NSString *gString = [cString substringWithRange:range];

    range.location = 4;
    NSString *bString = [cString substringWithRange:range];

    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];

    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
