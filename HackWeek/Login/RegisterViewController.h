//
//  RegisterViewController.h
//  HackWeek
//
//  Created by New on 2020/7/28.
//  Copyright © 2020 Godlowd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RegisterViewController : UIViewController
@property(nonatomic, strong) UILabel *bigTitle;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UITextField *email;
@property(nonatomic, strong) UITextField *verifyCode;
@property(nonatomic, strong) UITextField *paswword;
@property(nonatomic, strong) UITextField *confirmPassword;

@property(nonatomic, strong) UIButton *getVerifyCode;
@property(nonatomic, strong) UIButton *registerBtn;

@property(nonatomic) BOOL *whetherregistersuccessfully;
@end

NS_ASSUME_NONNULL_END
