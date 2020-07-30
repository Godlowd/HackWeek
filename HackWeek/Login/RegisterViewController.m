//
//  RegisterViewController.m
//  HackWeek
//
//  Created by New on 2020/7/28.
//  Copyright © 2020 Godlowd. All rights reserved.
//

#import "RegisterViewController.h"
#import <Masonry.h>
#import <AFNetworking.h>
@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self titleInit];
    [self textFieldInit];
    [self registerBtnInit];
    // Do any additional setup after loading the view.
}

#pragma mark click
-(void)getCode{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSString *emailtext = _email.text;
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager POST:@"http://s1.996404.xyz:3000/api/v1/user/info" parameters:@{@"email": emailtext} progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.getVerifyCode setTitle:@"重新获取验证码" forState:UIControlStateNormal];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"获取验证码失败");
    }];
}

# pragma mark Init
-(void)titleInit{
   self.bigTitle = UILabel.new;
        self.bigTitle.text = @"1037号树洞";
        self.bigTitle.font = [UIFont systemFontOfSize:25];
        [self.view addSubview:self.bigTitle];
        [self.bigTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.view.mas_top).with.offset(100);
            make.height.mas_equalTo(25);
    //        make.top.equalTo(self.view.mas_top).with.offset(108);
        }];
    
    _titleLabel = UILabel.new;
    _titleLabel.font = [UIFont systemFontOfSize:20];
    _titleLabel.text = @"邮箱注册";
    [self.view addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.bigTitle.mas_bottom).with.offset(50);
        make.height.mas_equalTo(20);
    }];
    
}

-(void)textFieldInit{
   _email = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    [self.view addSubview:_email];
    [_email mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(50);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(256);
    }];
    _email.backgroundColor = [self colorWithHexString:@"f8f6f9"];
    _email.font = [UIFont systemFontOfSize:25];
    _email.clearButtonMode = UITextFieldViewModeWhileEditing;
    _email.layer.borderColor = [UIColor.blackColor CGColor];
    _email.layer.borderWidth = 1;
    _email.layer.cornerRadius = 5;
    _email.autocapitalizationType=UITextAutocapitalizationTypeNone;
    NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc] initWithString:@"请输入华中大邮箱" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18]}];
    _email.attributedPlaceholder = placeholderString;
    
    _verifyCode = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    [self.view addSubview:_verifyCode];
    [_verifyCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(256);
        make.top.equalTo(self.email.mas_bottom).with.offset(30);
        make.height.mas_equalTo(50);
    }];
    _verifyCode.backgroundColor = [self colorWithHexString:@"f8f6f9"];
    _verifyCode.font = [UIFont systemFontOfSize:25];
    _verifyCode.clearButtonMode = UITextFieldViewModeWhileEditing;
    _verifyCode.layer.cornerRadius = 5;
    placeholderString = [[NSMutableAttributedString alloc] initWithString:@"请输入验证码" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18]}];
    _verifyCode.attributedPlaceholder = placeholderString;
    _verifyCode.autocapitalizationType=UITextAutocapitalizationTypeNone;
    
    _getVerifyCode = [UIButton buttonWithType:UIButtonTypeCustom];
    [_getVerifyCode setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [self.view addSubview:_getVerifyCode];
    [_getVerifyCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.verifyCode);
        make.top.equalTo(self.verifyCode.mas_bottom).with.offset(30);
        make.height.mas_equalTo(10);
        
    }];
    [_getVerifyCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_getVerifyCode addTarget:self action:@selector(getCode) forControlEvents:UIControlEventTouchUpInside];
    
    _paswword = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    [self.view addSubview:_paswword];
    [_paswword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(256);
        make.top.equalTo(self.getVerifyCode.mas_bottom).with.offset(80);
        make.height.mas_equalTo(50);
    }];
    _paswword.font = [UIFont systemFontOfSize:25];
    _paswword.clearButtonMode = UITextFieldViewModeWhileEditing;
    _paswword.backgroundColor = [self colorWithHexString:@"f8f6f9"];
    placeholderString = [[NSMutableAttributedString alloc] initWithString:@"请设置密码" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18]}];
    _paswword.attributedPlaceholder = placeholderString;
    _paswword.layer.cornerRadius = 5;
    _paswword.autocapitalizationType=UITextAutocapitalizationTypeNone;
    
    _confirmPassword = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    [self.view addSubview:_confirmPassword];
    [_confirmPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(256);
        make.top.equalTo(self.paswword.mas_bottom).with.offset(30);
        make.height.mas_equalTo(50);
    }];
    _confirmPassword.font = [UIFont systemFontOfSize:25];
    _confirmPassword.clearButtonMode = UITextFieldViewModeWhileEditing;
    _confirmPassword.backgroundColor = [self colorWithHexString:@"f8f6f9"];
    placeholderString = [[NSMutableAttributedString alloc] initWithString:@"请重复密码" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18]}];
    _confirmPassword.attributedPlaceholder = placeholderString;
    _confirmPassword.layer.cornerRadius = 5;
    _confirmPassword.autocapitalizationType=UITextAutocapitalizationTypeNone;
}
-(void)registerBtnInit{
    _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [_registerBtn setTitleColor: UIColor.blackColor forState:UIControlStateNormal];
    _registerBtn.backgroundColor = [self colorWithHexString:@"435b5c"];
    [_registerBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [self.view addSubview:_registerBtn];
    [_registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(338);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.confirmPassword.mas_bottom).with.offset(80);
        make.height.mas_equalTo(81);
    }];
    _registerBtn.layer.cornerRadius = 10;
    
//    [_registerBtn addTarget:self action:@selector(registerUser) forControlEvents:UIControlEventTouchUpInside];
}
# pragma mark set Color
-(UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];

    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];

    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];

    if ([cString length] != 6) return  [UIColor grayColor];

    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];

    range.location = 2;
    NSString *gString = [cString substringWithRange:range];

    range.location = 4;
    NSString *bString = [cString substringWithRange:range];

    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];

    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
