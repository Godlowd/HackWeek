//
//  MainViewController.h
//  HackWeek
//
//  Created by New on 2020/7/27.
//  Copyright © 2020 Godlowd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MainViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UITableView *page;
@property(nonatomic, strong) UITableView *message;
@property(nonatomic, strong) UITableView *profile;
@end

NS_ASSUME_NONNULL_END
