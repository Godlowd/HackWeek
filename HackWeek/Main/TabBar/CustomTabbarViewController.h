//
//  CustomTabbarViewController.h
//  HackWeek
//
//  Created by New on 2020/7/29.
//  Copyright © 2020 Godlowd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfo.h"
NS_ASSUME_NONNULL_BEGIN

@interface CustomTabbarViewController : UITabBarController
@property(nonatomic, strong) UserInfo *userinfo;
-(instancetype)init;
@end

NS_ASSUME_NONNULL_END
