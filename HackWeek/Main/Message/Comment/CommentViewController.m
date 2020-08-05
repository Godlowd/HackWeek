//
//  CommentViewController.m
//  HackWeek
//
//  Created by New on 2020/8/6.
//  Copyright © 2020 Godlowd. All rights reserved.
//

#import "CommentViewController.h"
#import <Masonry.h>
#import "CommentTableViewCell.h"
@interface CommentViewController ()

@end

@implementation CommentViewController
NSString *commentreusecell = @"commentreusecell";
- (void)viewDidLoad {
    [super viewDidLoad];
    [self tableViewInit];
    // Do any additional setup after loading the view.
}
#pragma mark - UITableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:commentreusecell];
    [cell initAvatarTitleContentTime];
    cell.title.text = @"已匿名";
    cell.time.text = @"08:59";
    cell.content.text = @"今天的饭很好吃";
    return cell;
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
#pragma mark - Init
-(void)tableViewInit{
    _commentTableView = UITableView.new;
    _commentTableView.delegate = self;
    _commentTableView.dataSource = self;
    _commentTableView.tableFooterView = UIView.new;
    _commentTableView.tableFooterView.backgroundColor = [self colorWithHexString:@"f0f0f0"];
    [_commentTableView registerClass:CommentTableViewCell.class forCellReuseIdentifier:commentreusecell];
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
