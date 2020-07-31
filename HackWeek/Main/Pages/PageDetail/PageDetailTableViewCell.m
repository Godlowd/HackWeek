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

-(instancetype)init{
    self = [super init];
    self.avatar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, AVATAR_WIDTH, AVATAR_HEIGHT)];
    self.name = UILabel.new;
    self.name.text = @"(已匿名)";
    [self addSubview:self.name];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatar.mas_right).with.offset(10);
        make.top.equalTo(self.avatar.mas_top);
    }];
    
    self.time = UILabel.new;
    self.time.text = @"";
    [self addSubview:self.time];
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatar.mas_right).with.offset(10);
        make.bottom.equalTo(self.avatar.mas_bottom);
    }];
    self.content = UILabel.new;
    
    self.comment = [UIButton buttonWithType:UIButtonTypeCustom];
    self.good = [UIButton buttonWithType:UIButtonTypeCustom];
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
