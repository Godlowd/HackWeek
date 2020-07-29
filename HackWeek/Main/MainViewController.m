//
//  MainViewController.m
//  HackWeek
//
//  Created by New on 2020/7/27.
//  Copyright © 2020 Godlowd. All rights reserved.
//

#import "MainViewController.h"
#import <Masonry.h>
@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:true];
    // Do any additional setup after loading the view.
}

-(void)headerViewInit{
    UIView *header = [[UIView alloc] init];
    [self.view addSubview:header];
    [header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.height.mas_equalTo(107);
        make.top.equalTo(self.view);
    }];
    
    UILabel *title = UILabel.new;
    title.text = @"1037号树洞";
    title.font = [UIFont systemFontOfSize:30];
    [header addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(header);
        make.top.equalTo(header.mas_top).with.offset(50);
        make.height.mas_equalTo(30);
    }];
    
    UIButton *newPage = [UIButton buttonWithType:UIButtonTypeCustom];
    newPage.frame = CGRectMake(0, 0, 26, 26);
    [newPage setBackgroundImage:[UIImage imageNamed:@"发布"] forState:UIControlStateNormal];
    [header addSubview:newPage];
    [newPage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(header.mas_right).with.offset(-53);
        make.top.equalTo(header.mas_top).with.offset(42);
    }];
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
