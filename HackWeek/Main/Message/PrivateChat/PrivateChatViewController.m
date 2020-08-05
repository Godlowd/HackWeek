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
NSString *privatecha = @"privatecha";

-(instancetype)init{
    self  = [super init];
    [self tableViewInit];
    return  self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
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
    PrivateChatTableViewCell *cell = [self.privateChatTableView dequeueReusableCellWithIdentifier:privatecha];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.privateChatTableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
#pragma mark - Init
-(void)tableViewInit{
    _privateChatTableView = UITableView.new;
    [self.view addSubview:_privateChatTableView];
    [_privateChatTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.privateChatTableView.delegate = self;
    self.privateChatTableView.dataSource = self;
    [self.privateChatTableView registerClass:PrivateChatTableViewCell.class forCellReuseIdentifier:privatecha];
    self.privateChatTableView.tableFooterView = UIView.new;
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
