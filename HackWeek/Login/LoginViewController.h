//
//  LoginViewController.h
//  HackWeek
//
//  Created by New on 2020/7/27.
//  Copyright © 2020 Godlowd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfo.h"
NS_ASSUME_NONNULL_BEGIN

@interface LoginViewController : UIViewController
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UIButton *loginByPassword;
@property(nonatomic, strong) UIButton *loginByVerify;
@property(nonatomic, strong) UITextField *account;
@property(nonatomic, strong) UITextField *password;
@property(nonatomic, strong) UITextField *setPassword;
@property(nonatomic, strong) UIButton *loginbtn;
@property(nonatomic, strong) UIView *containerView;
@property(nonatomic, strong) UIButton *registerBtn;
@property(nonatomic, strong) UserInfo *userinfo;
@end

NS_ASSUME_NONNULL_END
