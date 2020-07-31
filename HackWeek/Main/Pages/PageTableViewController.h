//
//  PageTableViewController.h
//  HackWeek
//
//  Created by New on 2020/7/29.
//  Copyright © 2020 Godlowd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfo.h"
#import "CustomTabbarViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface PageTableViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) NSMutableArray *pages;
@property(nonatomic, strong) UITableView *pageView;
@property(nonatomic, strong) UIView *container;
@property(nonatomic, strong) UIView *header;
@property(nonatomic, strong) UserInfo *userinfo;
@property(nonatomic, strong) CustomTabbarViewController *tabbar;


@end

NS_ASSUME_NONNULL_END
