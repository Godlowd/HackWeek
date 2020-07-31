//
//  PageDetailViewController.h
//  HackWeek
//
//  Created by New on 2020/7/31.
//  Copyright © 2020 Godlowd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PageDetailViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
//帖子id
@property(nonatomic, strong) NSString *pageId;
//帖子内容
@property(nonatomic, strong) NSDictionary *pageDetailDict;
@end

NS_ASSUME_NONNULL_END
