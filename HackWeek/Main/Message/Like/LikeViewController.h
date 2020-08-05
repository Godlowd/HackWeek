//
//  LikeViewController.h
//  HackWeek
//
//  Created by New on 2020/8/6.
//  Copyright © 2020 Godlowd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LikeViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong) UITableView *likeTableView;
@end

NS_ASSUME_NONNULL_END
