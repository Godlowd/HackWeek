//
//  BaseViewController.m
//  HackWeek
//
//  Created by New on 2020/8/1.
//  Copyright © 2020 Godlowd. All rights reserved.
//

#import "BaseViewController.h"
#import <Masonry.h>

#import "PrivateChatTableViewCell.h"

#import "LikeTableViewCell.h"
#import "CommentTableViewCell.h"
@interface BaseViewController ()

@end

@implementation BaseViewController
NSString *privatechat = @"privatechat";
NSString *likereusecell = @"likereusecell";
NSString *commentreusecell = @"commentreusecell";
- (void)viewDidLoad {
    [super viewDidLoad];
    [self navBarInit];
    [self mainViewInit];
    
    // Do any additional setup after loading the view.
}

#pragma mark - Init
-(void)mainViewInit{
    _mainView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _mainView.delegate = self;

    _mainView.pagingEnabled = YES;
//    _mainView.showsHorizontalScrollIndicator = NO;
//    _mainView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_mainView];
    [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_navBar.mas_bottom);
        make.left.and.right.and.bottom.equalTo(self.view);
    }];
    _container = [[UIView alloc] init];
    [_mainView addSubview:_container];
    [_container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_mainView);
        make.height.equalTo(_mainView);
    }];


   _privateChatTableView = UITableView.new;
   [_container addSubview:_privateChatTableView];
   [_privateChatTableView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(_container);
       make.top.equalTo(_container);
       make.height.mas_equalTo(UIScreen.mainScreen.bounds.size.height);
       make.width.mas_equalTo(UIScreen.mainScreen.bounds.size.width);
   }];
    _privateChatTableView.tableFooterView = UIView.new;
    _privateChatTableView.tableFooterView.backgroundColor = [self colorWithHexString:@"f0f0f0"];
   self.privateChatTableView.delegate = self;
   self.privateChatTableView.dataSource = self;
    _privateChatTableView.tag = 1;
   [self.privateChatTableView registerClass:PrivateChatTableViewCell.class forCellReuseIdentifier:privatechat];
    
    _likeTableView = UITableView.new;
    _likeTableView.delegate = self;
    _likeTableView.dataSource = self;
    _likeTableView.tableFooterView = UIView.new;
    _likeTableView.tableFooterView.backgroundColor = [self colorWithHexString:@"f0f0f0"];
    [_likeTableView registerClass:LikeTableViewCell.class forCellReuseIdentifier:likereusecell];
    [_container addSubview:_likeTableView];
    [_likeTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.privateChatTableView.mas_right);
        make.top.equalTo(_container);
        make.height.mas_equalTo(UIScreen.mainScreen.bounds.size.height);
        make.width.mas_equalTo(UIScreen.mainScreen.bounds.size.width);
    }];
    _likeTableView.tag = 2;
    
    _commentTableView = UITableView.new;
    _commentTableView.delegate = self;
    _commentTableView.dataSource = self;
    _commentTableView.tableFooterView = UIView.new;
    _commentTableView.tableFooterView.backgroundColor = [self colorWithHexString:@"f0f0f0"];
    [_commentTableView registerClass:CommentTableViewCell.class forCellReuseIdentifier:commentreusecell];
    [_container addSubview:_commentTableView];
    [_commentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.likeTableView.mas_right);
        make.top.equalTo(_container);
        make.height.mas_equalTo(UIScreen.mainScreen.bounds.size.height);
        make.width.mas_equalTo(UIScreen.mainScreen.bounds.size.width);
        make.right.equalTo(self.container.mas_right).with.offset(0);
    }];
    _commentTableView.tag = 3;

}

-(void)navBarInit{
    _navBar = UIView.new;
    [self.view addSubview:_navBar];
    [_navBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(84);
    }];
    _navBar.backgroundColor = UIColor.whiteColor;
    
    UIButton *private = [UIButton buttonWithType:UIButtonTypeCustom];
    [private setTitle:@"私信" forState:UIControlStateNormal];
    [_navBar addSubview:private];
    [private addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
    private.tag = 0;
    [private setTitleColor:[self colorWithHexString:@"435b5c"] forState:UIControlStateNormal];
    
    UIButton *like = [UIButton buttonWithType:UIButtonTypeCustom];
    [like setTitle:@"赞" forState:UIControlStateNormal];
    [_navBar addSubview:like];
    [like addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
    like.tag = 1;
    [like setTitleColor:[self colorWithHexString:@"#B3B3B3"] forState:UIControlStateNormal];
    
    UIButton *comment = [UIButton buttonWithType:UIButtonTypeCustom];
    [comment setTitle:@"评论" forState:UIControlStateNormal];
    [_navBar addSubview:comment];
    [comment addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
    comment.tag = 2;
    [comment setTitleColor:[self colorWithHexString:@"#B3B3B3"] forState:UIControlStateNormal];
    
    _navBarArray = @[private, like, comment];
    [_navBarArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:30 leadSpacing:100 tailSpacing:100];
    [_navBarArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_navBar).with.offset(30);
        make.bottom.equalTo(_navBar).with.offset(-5);
    }];
}
#pragma mark - SEL
-(void)tap:(UIButton *)button{
    NSLog(@"the tag is %ld",(long)button.tag);
    [_mainView setContentOffset:CGPointMake(button.tag * UIScreen.mainScreen.bounds.size.width, 0) animated:YES];
    for (UIButton *btn in _navBarArray) {
        [btn setTitleColor:[self colorWithHexString:@"#B3B3B3"] forState:UIControlStateNormal];
    }
    [button setTitleColor:[self colorWithHexString:@"435b5c"] forState:UIControlStateNormal];
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 1) {
        PrivateChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:privatechat];
    
        [cell initAvatarTitleContentTime];
        
        return cell;
    }
    else if(tableView.tag == 2){
        LikeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:likereusecell];
        if (indexPath.row != 2) {
            [cell initAvatarTitleTimeDetailView];
        }
        else {
            [cell initAvatarTitleTimeCommentDetailView];
        }
        return cell;
    }
    else {
        CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:commentreusecell];
        [cell initAvatarTitleTimeCommentDetailView:indexPath];
        return cell;
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int tag =  (int)self.mainView.contentOffset.x / UIScreen.mainScreen.bounds.size.width;
    for (UIButton *btn in _navBarArray) {
        if (btn.tag == tag) {
            [btn setTitleColor:[self colorWithHexString:@"435b5c"] forState:UIControlStateNormal];
        }
        else{
            [btn setTitleColor:[self colorWithHexString:@"#B3B3B3"] forState:UIControlStateNormal];
        }
    }
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

        return 3;//default value
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
# pragma mark - set Color
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
