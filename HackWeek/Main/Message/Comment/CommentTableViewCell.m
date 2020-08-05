//
//  CommentTableViewCell.m
//  HackWeek
//
//  Created by New on 2020/8/6.
//  Copyright © 2020 Godlowd. All rights reserved.
//

#import "CommentTableViewCell.h"
#import <Masonry.h>
@implementation CommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)initAvatarTitleTimeCommentDetailView:(NSIndexPath *)indexpath{
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
        make.top.equalTo(self).with.offset(16);
        make.left.equalTo(_avatar.mas_right).with.offset(10);
    }];
    
    _time = UILabel.new;
    _time.text = @"08:59";
    [self addSubview:_time];
    [_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).with.offset(-20);
        make.top.equalTo(_title);
    }];
    
    _detailcomment = UILabel.new;
    [self addSubview:_detailcomment];
    [_detailcomment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_title);
        make.top.equalTo(_title.mas_bottom).with.offset(15);
    }];
    
    _detailView = UIView.new;
    _detailView.backgroundColor = UIColor.whiteColor;
   [self addSubview:_detailView];
   [_detailView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.right.equalTo(self.time);
       make.top.equalTo(self.detailcomment.mas_bottom).with.offset(15);
       make.left.equalTo(self.title);
       make.bottom.equalTo(self.mas_bottom).with.offset(-15);
   }];
    _detailView.layer.cornerRadius = 5;
    
   UILabel *comment = UILabel.new;
   comment.text = @"(已匿名)： 今天的饭很好吃";
   [_detailView addSubview:comment];
   [comment mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self.detailView.mas_left).with.offset(10);
       make.top.equalTo(self.detailView).with.offset(10);
       make.right.equalTo(self.detailView).with.offset(-10);
       make.bottom.equalTo(self.detailView).with.offset(-10);
   }];
    
    if (indexpath.row == 0) {
        _detailcomment.text = @"今天的饭很好吃";
        _title.text = @"(已匿名)评论了你的帖子";
    }
    else{
        _detailcomment.text = @"今天的饭很好吃//(已匿名):真的吗";
        _title.text = @"(已匿名)回复了你的评论";
    }
        
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
