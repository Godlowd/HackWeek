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
//私信tableview
@property(nonatomic, strong) UITableView *privateChatTableView;
//私信列表
@property(nonatomic, strong) NSMutableArray *charArray;
//赞tableview
@property(nonatomic, strong) UITableView *likeTableView;
//评论tableview
@property(nonatomic, strong) UITableView *commentTableView;
-(instancetype)init;
@end

NS_ASSUME_NONNULL_END
