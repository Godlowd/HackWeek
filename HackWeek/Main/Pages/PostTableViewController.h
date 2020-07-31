//
//  PostTableViewController.h
//  HackWeek
//
//  Created by New on 2020/7/29.
//  Copyright © 2020 Godlowd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomImageVIew.h"
NS_ASSUME_NONNULL_BEGIN

@interface PostTableViewController : UITableViewController<UITableViewDelegate, UITableViewDataSource, UITextViewDelegate,UIImagePickerControllerDelegate>
@property(nonatomic, strong) UIButton *postPage;
@property(nonatomic, strong) UIButton *cancel;
@property(nonatomic, strong) UIButton *setting;
@property(nonatomic, strong) UIButton *back;
@property(nonatomic, strong) NSMutableArray *imageArray;
@property(nonatomic, strong) CustomImageVIew *customimageview;
@property(nonatomic, strong) UIButton *addBtn;
@end

NS_ASSUME_NONNULL_END
