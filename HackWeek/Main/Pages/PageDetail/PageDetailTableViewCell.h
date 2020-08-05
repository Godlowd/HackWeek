//
//  PageDetailTableViewCell.h
//  HackWeek
//
//  Created by New on 2020/7/31.
//  Copyright © 2020 Godlowd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PageDetailTableViewCell : UITableViewCell
@property(nonatomic, strong) UIImageView *avatar;
@property(nonatomic, strong) UILabel *name;
@property(nonatomic, strong) UILabel *content;
@property(nonatomic, strong) UILabel *time;
@property(nonatomic, strong) UILabel *title;

@property(nonatomic, strong) UIButton *comment;
@property(nonatomic, strong) UIButton *good;

-(void)initAvatarTimeNameContent;
-(void)initAvatarTimeNameTitleContent;
@end

NS_ASSUME_NONNULL_END
