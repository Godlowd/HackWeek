//
//  PrivateChatViewController.m
//  HackWeek
//
//  Created by New on 2020/8/1.
//  Copyright © 2020 Godlowd. All rights reserved.
//

#import "PrivateChatViewController.h"
#import <Masonry.h>
#import "PrivateChatTableViewCell.h"
@interface PrivateChatViewController ()

@end

@implementation PrivateChatViewController
NSString *privatechat = @"privatechat";
- (void)viewDidLoad {
    [super viewDidLoad];
    [self tableViewInit];
    // Do any additional setup after loading the view.
}
#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_charArray) {
        return [_charArray count];
    }
    else{
        return 3;//default value
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PrivateChatTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:privatechat];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
#pragma mark - Init
-(void)tableViewInit{
    _tableView = UITableView.new;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:PrivateChatTableViewCell.class forCellReuseIdentifier:privatechat];
    self.tableView.tableFooterView = UIView.new;
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
