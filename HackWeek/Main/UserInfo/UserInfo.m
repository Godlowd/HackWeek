//
//  UserInfo.m
//  HackWeek
//
//  Created by New on 2020/7/29.
//  Copyright © 2020 Godlowd. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo
UserInfo *info = nil;
+(instancetype)shareInstance{
    if (info == nil) {
        static dispatch_once_t onceToken;   //①onceToken = 0;
        
        dispatch_once(&onceToken, ^{
            NSLog(@"%ld",onceToken);        //②onceToken = 140734731430192
            info = [[UserInfo alloc] init];
        });
        
        NSLog(@"%ld",onceToken);            //③onceToken = -1;
    }
        
        return info;
}
@end
