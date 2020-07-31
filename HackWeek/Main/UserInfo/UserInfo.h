//
//  UserInfo.h
//  HackWeek
//
//  Created by New on 2020/7/29.
//  Copyright © 2020 Godlowd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserInfo : NSObject
@property(nonatomic, strong) NSString *token;
@property(nonatomic, strong) NSString *userId;
@property(nonatomic) NSInteger *expire_time;
//单例生成方法
+(instancetype)shareInstance;
@end

NS_ASSUME_NONNULL_END
