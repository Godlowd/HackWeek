//
//  PrivateChatTableViewCell.m
//  HackWeek
//
//  Created by New on 2020/8/1.
//  Copyright © 2020 Godlowd. All rights reserved.
//

#import "PrivateChatTableViewCell.h"
#import <Masonry.h>
@implementation PrivateChatTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)initAvatarTitleContentTime{
    self.backgroundColor = [self colorWithHexString:@"f0f0f0"];
    _avatar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 52, 52)];
    UIImage *img = [UIImage imageNamed:@"白色头像"];
    _avatar.image = img;
    [self addSubview:_avatar];
    [_avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(20);
        make.top.equalTo(self.mas_top).with.offset(20);
        make.height.mas_equalTo(52);
        make.width.mas_equalTo(52);
    }];
    _avatar.layer.cornerRadius = 52/2;
    _avatar.clipsToBounds = true;
    
    
    _title = UILabel.new;
    [self addSubview:_title];
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatar.mas_right).with.offset(27);
        make.top.equalTo(self).with.offset(20);
        make.height.mas_equalTo(20);
    }];
    _title.font = [UIFont systemFontOfSize:20];
    _title.text = @"已匿名";
    
    _content = UILabel.new;
    [self addSubview:_content];
    [_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatar.mas_right).with.offset(27);
        make.top.equalTo(self.title).with.offset(54);
        make.height.mas_equalTo(15);
        make.bottom.equalTo(self).with.offset(-20);
    }];
    _content.font = [UIFont systemFontOfSize:15];
    _content.text = @"今天的饭很好吃";
    
    _time = UILabel.new;
    [self addSubview:_time];
    [_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).with.offset(-30);
        make.top.equalTo(self.title);
        make.height.mas_equalTo(15);
    }];
    _time.font = [UIFont systemFontOfSize:15];
    _time.text = @"08:59";

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
@end
