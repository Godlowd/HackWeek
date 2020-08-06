//
//  PageTableViewCell.m
//  HackWeek
//
//  Created by New on 2020/7/29.
//  Copyright © 2020 Godlowd. All rights reserved.
//

#import "PageTableViewCell.h"
#import <Masonry.h>
@implementation PageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)initAvatarTitleContentTime{
    _avatar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 52, 52)];
    [self addSubview:_avatar];
    [_avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(20);
        make.top.equalTo(self.mas_top).with.offset(20);
        make.height.mas_equalTo(52);
        make.width.mas_equalTo(52);
    }];
    _avatar.layer.cornerRadius = 52/2;
    _avatar.clipsToBounds = true;
    
    _time = UILabel.new;
    [self addSubview:_time];
    [_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).with.offset(-30);
        make.top.equalTo(self).with.offset(20);
        make.height.mas_equalTo(15);
    }];
    _time.font = [UIFont systemFontOfSize:15];
    
    _title = UILabel.new;
    [self addSubview:_title];
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatar.mas_right).with.offset(27);
        make.right.equalTo(self.time.mas_right).with.offset(-5);
        make.top.equalTo(self).with.offset(20);
        make.height.mas_equalTo(20);
    }];
    _title.font = [UIFont systemFontOfSize:20];
    _title.lineBreakMode = NSLineBreakByWordWrapping;
    _title.numberOfLines = 0;
    
    _content = UILabel.new;
    [self addSubview:_content];
    [_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatar.mas_right).with.offset(27);
        make.right.equalTo(self.time.mas_right);
        make.top.equalTo(self.title).with.offset(54);
        make.height.mas_equalTo(15);
        make.bottom.equalTo(self).with.offset(-20);
    }];
    _content.font = [UIFont systemFontOfSize:15];
    


}

@end
