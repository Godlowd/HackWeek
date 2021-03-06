//
//  PageDetailTableViewCell.m
//  HackWeek
//
//  Created by New on 2020/7/31.
//  Copyright © 2020 Godlowd. All rights reserved.
//

#import "PageDetailTableViewCell.h"
#import <Masonry.h>
#define AVATAR_WIDTH 52
#define AVATAR_HEIGHT AVATAR_WIDTH
@implementation PageDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)initAvatarTimeNameContent{
    self.avatar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, AVATAR_WIDTH, AVATAR_HEIGHT)];
    _avatar.image = [UIImage imageNamed:@"白色头像"];
    [self addSubview:self.avatar];
    [self.avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(34);
        make.top.equalTo(self).with.offset(34);
        make.height.mas_equalTo(AVATAR_HEIGHT);
        make.width.mas_equalTo(AVATAR_WIDTH);
    }];
    _avatar.layer.cornerRadius = 52/2;
    _avatar.clipsToBounds = true;
    
    self.name = UILabel.new;
    self.name.text = @"(已匿名)";
    [self addSubview:self.name];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatar.mas_right).with.offset(20);
        make.top.equalTo(self.avatar.mas_top);
    }];
    
    self.time = UILabel.new;
    [self addSubview:self.time];
    self.time.font = [UIFont systemFontOfSize:15];
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatar.mas_right).with.offset(20);
        make.height.mas_equalTo(15);
        make.top.equalTo(self.name.mas_bottom).with.offset(10);
    }];
    
    self.content = UILabel.new;
    [self addSubview:self.content];
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatar.mas_bottom).with.offset(20);
        make.left.equalTo(self.time);
        make.right.equalTo(self).with.offset(-30);
        make.bottom.equalTo(self).with.offset(-10);
    }];
    self.content.font = [UIFont systemFontOfSize:16];
    self.comment = [UIButton buttonWithType:UIButtonTypeCustom];
    self.good = [UIButton buttonWithType:UIButtonTypeCustom];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}


-(void)initAvatarTimeNameTitleContent{
    self.avatar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, AVATAR_WIDTH, AVATAR_HEIGHT)];
    [self addSubview:self.avatar];
    _avatar.image = [UIImage imageNamed:@"白色头像"];
    [self.avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(34);
        make.top.equalTo(self).with.offset(34);
        make.height.mas_equalTo(AVATAR_HEIGHT);
        make.width.mas_equalTo(AVATAR_WIDTH);
    }];
    self.avatar.layer.cornerRadius = 25;
    self.avatar.clipsToBounds;
    
    self.name = UILabel.new;
    self.name.text = @"(已匿名)";
    [self addSubview:self.name];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatar.mas_right).with.offset(20);
        make.top.equalTo(self.avatar.mas_top);
    }];
    
    self.time = UILabel.new;
    [self addSubview:self.time];
    self.time.font = [UIFont systemFontOfSize:15];
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatar.mas_right).with.offset(20);
        make.height.mas_equalTo(15);
        make.top.equalTo(self.name.mas_bottom).with.offset(10);
    }];
    
    self.title = UILabel.new;
    [self addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatar.mas_bottom).with.offset(50);
        make.left.equalTo(self.avatar);
        make.right.equalTo(self).with.offset(-30);
    }];
    
    self.content = UILabel.new;
    [self addSubview:self.content];
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.mas_bottom).with.offset(20);
        make.left.equalTo(self.avatar);
        make.right.equalTo(self).with.offset(-30);
        make.bottom.equalTo(self.mas_bottom).with.offset(-50);
    }];
    self.content.lineBreakMode = NSLineBreakByWordWrapping;
    self.content.numberOfLines = 0;
    
}
@end
