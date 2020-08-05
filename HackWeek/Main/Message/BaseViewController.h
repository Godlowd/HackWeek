//
//  BaseViewController.h
//  HackWeek
//
//  Created by New on 2020/8/1.
//  Copyright © 2020 Godlowd. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) UIScrollView *mainView;
@property(nonatomic, strong) UIView *container;
@property(nonatomic, strong) UIView *navBar;
@property(nonatomic, strong) UITableView *privateChatTableView;
@property(nonatomic, strong) UITableView *likeTableView;
@property(nonatomic, strong) UITableView *commentTableView;

@property(nonatomic, strong) NSArray *navBarArray;


@end

NS_ASSUME_NONNULL_END
