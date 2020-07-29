//
//  PostTableViewController.h
//  HackWeek
//
//  Created by New on 2020/7/29.
//  Copyright © 2020 Godlowd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PostTableViewController : UITableViewController<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) UIButton *postPage;
@property(nonatomic, strong) UIButton *cancel;
@property(nonatomic, strong) UIButton *setting;
@property(nonatomic, strong) UIButton *back;
@end

NS_ASSUME_NONNULL_END
