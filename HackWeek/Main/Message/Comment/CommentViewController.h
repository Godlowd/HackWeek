//
//  CommentViewController.h
//  HackWeek
//
//  Created by New on 2020/8/6.
//  Copyright © 2020 Godlowd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommentViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) UITableView *commentTableView;

@end

NS_ASSUME_NONNULL_END
