//
//  PrivateChatTableViewCell.h
//  HackWeek
//
//  Created by New on 2020/8/1.
//  Copyright © 2020 Godlowd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PrivateChatTableViewCell : UITableViewCell
@property(nonatomic, strong) UIImageView *avatar;
@property(nonatomic, strong) UILabel *title;
@property(nonatomic, strong) UILabel *content;
@property(nonatomic, strong) UILabel *time;
@end

NS_ASSUME_NONNULL_END
