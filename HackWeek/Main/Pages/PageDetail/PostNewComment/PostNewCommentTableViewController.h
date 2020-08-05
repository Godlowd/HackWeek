//
//  PostNewCommentTableViewController.h
//  HackWeek
//
//  Created by New on 2020/8/1.
//  Copyright © 2020 Godlowd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomImageVIew.h"
NS_ASSUME_NONNULL_BEGIN

@interface PostNewCommentTableViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate>
@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) UIButton *postPage;
@property(nonatomic, strong) UIButton *cancel;
@property(nonatomic, strong) UIButton *setting;
@property(nonatomic, strong) NSMutableArray *imageArray;

@property(nonatomic, strong) CustomImageVIew *customimageview;
@property(nonatomic, strong) UIButton *addBtn;

@property(nonatomic, strong) UITextView *text;

@property(nonatomic, copy) NSString *pageId;
@end

NS_ASSUME_NONNULL_END
