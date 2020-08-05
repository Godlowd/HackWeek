//
//  ProfileViewController.h
//  HackWeek
//
//  Created by New on 2020/8/6.
//  Copyright © 2020 Godlowd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController<UIImagePickerControllerDelegate>
//顶部导航栏
@property(nonatomic, strong) UIView *navBar;
//头像
@property(nonatomic, strong) UIImageView *avatar;
//用户名
@property(nonatomic, strong) UILabel *username;
//个人简介
@property(nonatomic, strong) UITextField *profile;
//展示图片
@property(nonatomic, strong) UIView *picture;
//背景条带
@property(nonatomic, strong) UIView *backgroundview;
@property(nonatomic, strong) NSMutableArray *imageArray;
@property(nonatomic, strong) UIButton *addBtn;
@end

NS_ASSUME_NONNULL_END
