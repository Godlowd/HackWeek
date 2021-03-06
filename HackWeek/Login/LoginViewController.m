//
//  LoginViewController.m
//  HackWeek
//
//  Created by New on 2020/7/27.
//  Copyright © 2020 Godlowd. All rights reserved.
//

#import "LoginViewController.h"
#import "MainViewController.h"
#import <Masonry.h>
#import <AFNetworking.h>
#import "RegisterViewController.h"
#import "PageTableViewController.h"
#import "UserInfo.h"
#import "CustomTabbarViewController.h"
#import "SceneDelegate.h"
#import "BaseViewController.h"
#import "ProfileViewController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;
    [self.view setBackgroundColor: [self colorWithHexString:@"435b5c"]]; /* white */
    [self containerInit];
    [self titleInit];
    [self loginWayInit];
    [self accountInit];
    [self passwordInit];
    [self loginbtnInit];
    [self registerBtnInit];
    // Do any additional setup after loading the view.
}
# pragma mark click
-(void)registerUser{
    RegisterViewController *controller = RegisterViewController.new;
    [self presentViewController:controller animated:YES completion:nil];
    
}

- (void)dismiss:(UIAlertController *)alert{
    [alert dismissViewControllerAnimated:YES completion:nil];
}
-(void)byVerify{
    NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc] initWithString:@"请输入验证码" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20]}];
    _password.attributedPlaceholder = placeholderString;
    [self.registerBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.password layoutIfNeeded];

}

-(void)byPassword{
    NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc] initWithString:@"请输入密码" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20]}];
    _password.attributedPlaceholder = placeholderString;
    [self.registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [self.password layoutIfNeeded];

}

-(void)loginPress{
    NSString *account = _account.text;
    NSString *password = _password.text;
    dispatch_queue_t queue = dispatch_get_global_queue(0, DISPATCH_QUEUE_PRIORITY_HIGH);
    dispatch_async(queue, ^{
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        NSString *url = [[@"http://s1.996404.xyz:3000/api/v1/user/token?email=" stringByAppendingString:account] stringByAppendingString:[NSString stringWithFormat:@"&password=%@",password]];
        NSLog(@"%@",url);
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"请求成功");
            
//            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"登录成功！" preferredStyle:UIAlertControllerStyleAlert];
//             [self presentViewController:alert animated:YES completion:nil];
//            //控制提示框显示的时间为2秒
//             [self performSelector:@selector(dismiss:) withObject:alert afterDelay:2.0];
            
            dispatch_semaphore_signal(semaphore);
            [UserInfo shareInstance].token = [[responseObject valueForKey:@"data"] valueForKey:@"token"];
            [UserInfo shareInstance].userId = [[responseObject valueForKey:@"data"] valueForKey:@"_id"];
            
            CustomTabbarViewController *controller =  [[CustomTabbarViewController alloc]init];
            controller.modalPresentationStyle = UIModalPresentationFullScreen;
            controller.delegate = controller;
            PageTableViewController *page = PageTableViewController.new;
            BaseViewController *base = BaseViewController.new;
            ProfileViewController *profile = ProfileViewController.new;
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:page];
            page.tabBarItem.image = [self scaleImg:[UIImage imageNamed:@"首页"] withSize:CGSizeMake(30, 30)];
            page.tabBarItem.title = @"首页";
            base.tabBarItem.image = [self scaleImg:[UIImage imageNamed:@"消息"] withSize:CGSizeMake(30, 30)];
            base.tabBarItem.title = @"消息";
            profile.tabBarItem.image = [self scaleImg:[UIImage imageNamed:@"我的"] withSize:CGSizeMake(30, 30)];
            profile.tabBarItem.title = @"我的";
            [controller addChildViewController:page];
            [controller addChildViewController:base];
            [controller addChildViewController:profile];
//            [self.navigationController pushViewController:controller animated:YES];
            [self presentViewController:controller animated:YES completion:nil];

            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            dispatch_semaphore_signal(semaphore);
            NSLog(@"请求失败fff");
        }];
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    });
    
}


# pragma mark Init
-(void)registerBtnInit{
    _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [_registerBtn setTitleColor:[self colorWithHexString:@"#B3B3B3"] forState:UIControlStateNormal];
    [self.containerView addSubview:_registerBtn];
    [_registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(80);
        make.right.equalTo(self.password);
        make.top.equalTo(self.password.mas_bottom).with.offset(30);
        make.bottom.equalTo(self.containerView.mas_bottom).with.offset(-20);
        make.height.mas_equalTo(20);
    }];
    [_registerBtn.titleLabel sizeToFit];
    _registerBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [_registerBtn addTarget:self action:@selector(registerUser) forControlEvents:UIControlEventTouchUpInside];
}

-(void)accountInit{
    _account = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    [self.containerView addSubview:_account];
    [_account mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containerView).with.offset(20);
        make.right.equalTo(self.containerView).with.offset(-20);
        make.top.equalTo(self.loginByPassword.mas_bottom).with.offset(30);
        make.height.mas_equalTo(35);
    }];
    _account.font = [UIFont systemFontOfSize:18];
    _account.clearButtonMode = UITextFieldViewModeWhileEditing;

    NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc] initWithString:@"请输入华中大邮箱" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18]}];
    _account.attributedPlaceholder = placeholderString;
    [_account setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    _account.layer.borderWidth = 1;
    _account.layer.borderColor = UIColor.blackColor.CGColor;
    _account.layer.cornerRadius = 5;
}

-(void)passwordInit{
    _password = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    [self.containerView addSubview:_password];
    [_password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containerView).with.offset(20);
        make.right.equalTo(self.containerView).with.offset(-20);
        make.top.equalTo(self.account.mas_bottom).with.offset(30);
        make.height.mas_equalTo(35);
    }];
    _password.font = [UIFont fontWithName:@"Arial" size:18];
    [_password setValue:[UIFont boldSystemFontOfSize:18] forKeyPath:@"placeholderLabel.font"];
    _password.clearButtonMode = UITextFieldViewModeWhileEditing;
    _password.secureTextEntry = YES;
    NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc] initWithString:@"请输入密码" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18]}];
    _password.textContentType = UITextContentTypeOneTimeCode;
   _password.attributedPlaceholder = placeholderString;

    _password.layer.borderWidth = 1;
    _password.layer.borderColor = UIColor.blackColor.CGColor;
    _password.layer.cornerRadius = 5;
}

-(void)containerInit{
    _containerView = [[UIView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    [self.view addSubview:_containerView];
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(65);
        make.right.equalTo(self.view).with.offset(-65);
        make.top.equalTo(self.view).with.offset(294);

    }];
    _containerView.backgroundColor = UIColor.whiteColor;
    _containerView.layer.cornerRadius = 10;
    _containerView.userInteractionEnabled = YES;
}

-(void)titleInit{
    self.titleLabel = UILabel.new;
    self.titleLabel.text = @"1037号树洞";
    self.titleLabel.font = [UIFont systemFontOfSize:40];
    [self.view addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.containerView.mas_top).with.offset(-56);
//        make.top.equalTo(self.view.mas_top).with.offset(108);
    }];
}
-(void)loginWayInit{
    _loginByPassword = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginByPassword.frame = CGRectMake(0, 0, 80, 30);
    [_loginByPassword setTitle:@"密码" forState:UIControlStateNormal];
    [_loginByPassword setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [self.containerView addSubview:_loginByPassword];
    [_loginByPassword addTarget:self action:@selector(byPassword) forControlEvents:UIControlEventTouchUpInside];
    [_loginByPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.containerView.mas_top).with.offset(46);
        make.left.equalTo(self.containerView).with.offset(40);
        make.height.mas_equalTo(20);
    }];

    
    _loginByVerify = [UIButton buttonWithType:UIButtonTypeCustom];
    [_loginByVerify setTitle:@"验证码" forState:UIControlStateNormal];
    [_loginByVerify setTitleColor:[self colorWithHexString:@"#425C5B"] forState:UIControlStateNormal];
    [self.containerView addSubview:_loginByVerify];
    [_loginByVerify addTarget:self action:@selector(byVerify) forControlEvents:UIControlEventTouchUpInside];
    [_loginByVerify mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.containerView.mas_top).with.offset(46);
        make.left.equalTo(self.loginByPassword).with.offset(40);
        make.right.equalTo(self.containerView).with.offset(-40);
        make.height.mas_equalTo(20);
    }];

}


-(void)loginbtnInit{
    _loginbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginbtn.frame = CGRectMake(0, 0, 80, 30);
    [_loginbtn setTitle:@"登陆" forState:UIControlStateNormal];
    _loginbtn.backgroundColor = UIColor.whiteColor;
    [_loginbtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [self.view addSubview:_loginbtn];
    [_loginbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(64);
        make.right.equalTo(self.view.mas_right).with.offset(-65);
        make.top.equalTo(self.containerView.mas_bottom).with.offset(45);
        make.height.mas_equalTo(81);
    }];
    _loginbtn.layer.cornerRadius = 10;
    _loginbtn.layer.borderColor = [UIColor.blackColor CGColor];
    _loginbtn.layer.borderWidth = 1;
    [_loginbtn addTarget:self action:@selector(loginPress) forControlEvents:UIControlEventTouchUpInside];
}



# pragma mark - set Color
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

-(UIImage *)scaleImg:(UIImage *)img withSize:(CGSize) wannaSize{
    UIImage *orignialImg = img;
    UIGraphicsBeginImageContextWithOptions(wannaSize, false, 0);
    [orignialImg drawInRect:CGRectMake(0, 0, wannaSize.width, wannaSize.height)];
    UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImg;
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
