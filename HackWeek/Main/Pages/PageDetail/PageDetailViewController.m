//
//  PageDetailViewController.m
//  HackWeek
//
//  Created by New on 2020/7/31.
//  Copyright © 2020 Godlowd. All rights reserved.
//

#import "PageDetailViewController.h"
#import <AFNetworking.h>
#import <Masonry.h>
#import "UserInfo.h"
#import "PageDetailTableViewCell.h"
#import "PostNewCommentTableViewController.h"
@interface PageDetailViewController ()

@end

@implementation PageDetailViewController
NSString *detailreusecell = @"detailreusecell";
- (void)viewDidLoad {
    [super viewDidLoad];
    [self tableViewInit];
    [self footerInit];
    
    
    // Do any additional setup after loading the view.
}
#pragma mark - SEL
-(void)post{
    PostNewCommentTableViewController *controller = PostNewCommentTableViewController.new;
    [self presentViewController:controller animated:YES completion:nil];
}

#pragma mark - Init
-(void)footerInit{
    _footerView = UIView.new;
    [self.view addSubview:_footerView];
    [_footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(self.view);
        make.top.equalTo(self.view.mas_bottom).with.offset(-80);
    }];
    _footerView.backgroundColor = [self colorWithHexString:@"#B3B3B3"];
    
    _comment = [UIButton buttonWithType:UIButtonTypeCustom];
    [_comment setImage:[UIImage imageNamed:@"评论"] forState:UIControlStateNormal];
    [_comment addTarget:self action:@selector(post) forControlEvents:UIControlEventTouchUpInside];
    [_footerView addSubview:_comment];
    [_comment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_footerView);
        make.left.equalTo(_footerView).with.offset(20);
    }];
}

-(void)tableViewInit{
    self.tableView = UITableView.new;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.tableView registerClass:PageDetailTableViewCell.class forCellReuseIdentifier:detailreusecell];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = UIView.new;
}
-(void)viewWillAppear:(BOOL)animated{
    self.pageDetailDict = NSDictionary.new;
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.completionQueue = dispatch_get_global_queue(0, DISPATCH_QUEUE_PRIORITY_DEFAULT);
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSString *url = [NSString stringWithFormat:@"http://s1.996404.xyz:3000/api/v1/post/%@",self.pageId];
    NSLog(@"%@",url);
    [manager.requestSerializer setValue: [NSString stringWithFormat:@"Bearer %@", [UserInfo shareInstance].token] forHTTPHeaderField:@"Authorization"];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"拉取帖子详细信息成功");
        self.pageDetailDict = [responseObject valueForKey:@"data"];
        dispatch_semaphore_signal(semaphore);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"拉取帖子详细信息失败");
        dispatch_semaphore_signal(semaphore);
    }];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    NSLog(@"the pageDetailDict: %@",self.pageDetailDict);
}
#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //第一楼是原来的帖子
    NSArray *array  = [_pageDetailDict valueForKey:@"reply"];
    return ([array count] + 1);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PageDetailTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:detailreusecell forIndexPath:indexPath];
    if (indexPath.row == 0) {
        
    }
    else{
        [cell initAvatarTimeNameContent];
        cell.avatar.image = [UIImage imageNamed:@"白色头像"];
        NSDictionary *dict = [_pageDetailDict valueForKey:@"reply"][indexPath.row-1];
        cell.time.text = [NSString stringWithFormat:@"%@",[dict valueForKey:@"updated_at"]];
        cell.content.text = [dict valueForKey:@"content"];
        [cell addSubview:cell.content];
//        [cell.content mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(cell.avatar.mas_right).with.offset(21);
//            make.top.equalTo(cell.time.mas_bottom).with.offset(10);
//            make.right.equalTo(cell.mas_right).with.offset(64);
//        }];
        
        [cell.good setImage:[UIImage imageNamed:@"good"] forState:normal];
        [cell addSubview:cell.good];
        [cell.good mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(cell.mas_right).with.offset(-63);
            make.bottom.equalTo(cell.content.mas_bottom);
            make.height.mas_equalTo(14);
            make.width.mas_equalTo(14);
        }];
        
        [cell.comment setImage:[UIImage imageNamed:@"comment"] forState:normal];
        [cell addSubview:cell.comment];
        [cell.comment mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(cell.good).with.offset(-5);
            make.bottom.equalTo(cell.content.mas_bottom);
            make.height.mas_equalTo(14);
            make.width.mas_equalTo(14);
        }];
        
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
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
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
