//
//  LikeTableViewCell.h
//  HackWeek
//
//  Created by New on 2020/8/6.
//  Copyright © 2020 Godlowd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LikeTableViewCell : UITableViewCell
@property(nonatomic, strong) UIImageView *avatar;
@property(nonatomic, strong) UILabel *title;
@property(nonatomic, strong) UILabel *time;
@property(nonatomic, strong) UILabel *detailcomment;
@property(nonatomic, strong) UIView *detailView;

-(void)initAvatarTitleTimeCommentDetailView;
-(void)initAvatarTitleTimeDetailView;
@end


NS_ASSUME_NONNULL_END
