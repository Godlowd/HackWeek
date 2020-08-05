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

@interface PostTableViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UITextViewDelegate,UIImagePickerControllerDelegate,UIGestureRecognizerDelegate>
@property(nonatomic, strong) UIButton *postPage;
@property(nonatomic, strong) UIButton *cancel;
@property(nonatomic, strong) UIButton *setting;
@property(nonatomic, strong) UIButton *back;
@property(nonatomic, strong) NSMutableArray *imageArray;
@property(nonatomic, strong) CustomImageVIew *customimageview;
@property(nonatomic, strong) UIButton *addBtn;
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) UISwitch *anonmous;
@property(nonatomic, strong) UIView *bottom;
@property(nonatomic, strong) UITextView *pageContent;
@property(nonatomic, strong) UITextField *pageTitle;
//底部匿名部分
@property(nonatomic, strong) UIView *container;
@property(nonatomic, strong) UIView *whetheranonymous;
@property(nonatomic, strong) UIView *blankview;
@property(nonatomic) BOOL *whetherHide;
@end

NS_ASSUME_NONNULL_END
