//
//  PrivateChatViewController.h
//  HackWeek
//
//  Created by New on 2020/8/1.
//  Copyright © 2020 Godlowd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PrivateChatViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong) UITableView *tableView;
//私信列表
@property(nonatomic, strong) NSMutableArray *charArray;

@end

NS_ASSUME_NONNULL_END
