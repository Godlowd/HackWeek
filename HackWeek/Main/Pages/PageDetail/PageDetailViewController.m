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
@interface PageDetailViewController ()

@end

@implementation PageDetailViewController
NSString *detailreusecell = @"detailreusecell";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSString *url = [@"http://s1.996404.xyz:3000/api/v1" stringByAppendingString:self.pageId];
    [manager.requestSerializer setValue:[UserInfo shareInstance].token forHTTPHeaderField:@"Authentication"];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"拉取帖子详细信息成功");
        self.pageDetailDict = [responseObject valueForKey:@"data"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"拉取帖子详细信息失败");
    }];
}
#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //第一楼是原来的帖子
    return [[_pageDetailDict valueForKey:@"reply"] count] + 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PageDetailTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:detailreusecell forIndexPath:indexPath];
    if (indexPath.row == 0) {
        
    }
    else{
        cell.avatar.image = [UIImage imageNamed:@"白色头像"];
        cell.time.text = [[_pageDetailDict valueForKey:@"reply"][indexPath.row-1] valueForKey:@"updated_at"];
        cell.content.text = [[_pageDetailDict valueForKey:@"reply"][indexPath.row-1] valueForKey:@"content"];
        [cell addSubview:cell.content];
        [cell.content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.avatar.mas_right).with.offset(21);
            make.top.equalTo(cell.time.mas_bottom).with.offset(10);
            make.right.equalTo(cell.mas_right).with.offset(64);
        }];
        
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
