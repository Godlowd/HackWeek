//
//  ProfileViewController.m
//  HackWeek
//
//  Created by New on 2020/8/6.
//  Copyright © 2020 Godlowd. All rights reserved.
//

#import "ProfileViewController.h"
#import "SettingTableViewController.h"
#import <Masonry.h>
#import "CustomImageVIew.h"
#define IMG_WIDTH 100
#define IMG_HEIGHT IMG_WIDTH
@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self navBarInit];
    [self backgroundInit];
    [self avatarInit];
    [self nameProfileInit];
    [self pictureInit];
    // Do any additional setup after loading the view.
}
#pragma mark - Init
-(void)pictureInit{
    self.picture = [[CustomImageVIew alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 50)];
    [self.view addSubview:self.picture];
    [self.picture mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.profile.mas_bottom).with.offset(50);
        make.bottom.mas_greaterThanOrEqualTo(self.view).with.offset(80);
        make.left.equalTo(self.view).with.offset(30);
        make.right.equalTo(self.view).with.offset(-30);
        make.height.mas_greaterThanOrEqualTo(124);
    }];
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addBtn setImage:[UIImage imageNamed:@"上传图片"] forState:UIControlStateNormal];
    [self.picture addSubview:_addBtn];
    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.picture).with.offset(IMG_WIDTH * (self.imageArray.count % 3) );
        make.top.equalTo(self.picture).with.offset(IMG_HEIGHT * (self.imageArray.count / 3 ));
        make.bottom.equalTo(self.picture).with.offset(-10);
    }];
    [_addBtn addTarget:self action:@selector(upLoadFile) forControlEvents:UIControlEventTouchUpInside];
}

-(void)nameProfileInit{
    _username = UILabel.new;
    _username.text = @"用户xi92s8";
    [self.view addSubview:_username];
    [_username mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.avatar.mas_bottom).with.offset(30);
    }];
    _username.font = [UIFont systemFontOfSize:20];
    
    _profile = UITextField.new;
    NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc] initWithString:@"说点什么呢" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]}];
    _profile.attributedPlaceholder = placeholderString;
    _profile.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:_profile];
    [_profile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.username.mas_bottom).with.offset(20);
    }];
    
}

-(void)avatarInit{
    _avatar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1"]];
    [self.view addSubview:_avatar];
    [_avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_backgroundview.mas_bottom);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(90);
    }];
    _avatar.layer.cornerRadius = 45;
    _avatar.clipsToBounds = true;
}
-(void)backgroundInit{
    _backgroundview = UIView.new;
    [self.view addSubview:_backgroundview];
    [_backgroundview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.navBar.mas_bottom);
        make.height.mas_equalTo(90);
    }];
    _backgroundview.backgroundColor = [self colorWithHexString:@"435b5c"];
}
-(void)navBarInit{
    _navBar = UIView.new;
    [self.view addSubview:_navBar];
    [_navBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(104);
    }];
    _navBar.backgroundColor = UIColor.whiteColor;
    
    UIButton *setting = [UIButton buttonWithType:UIButtonTypeCustom];
    [setting setImage:[UIImage imageNamed:@"设置"] forState:UIControlStateNormal];
    [_navBar addSubview:setting];
    [setting mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_navBar).with.offset(30);
        make.top.equalTo(_navBar).with.offset(50);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(40);
        make.bottom.mas_lessThanOrEqualTo(-10);
    }];
    [setting addTarget:self action:@selector(showSetting) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - SEL
-(void)test{
    NSLog(@"test");
}

-(void)showSetting{
    SettingTableViewController *vc = SettingTableViewController.new;
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:YES completion:nil];
}

-(void)upLoadFile{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"选择" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *lib = [UIAlertAction actionWithTitle:@"照片/视频" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            return;
        }
        //2.创建图片选择控制器
        UIImagePickerController *ipc = [[UIImagePickerController alloc]init];
        ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        ipc.delegate = self;
        //选中之后大图编辑模式
        ipc.allowsEditing = YES;
        [self presentViewController:ipc animated:YES completion:nil];
        
        
    }];
    UIAlertAction *capture = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            return;
        }
        //2.创建图片选择控制器
        UIImagePickerController *ipc = [[UIImagePickerController alloc]init];
        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
        ipc.delegate = self;
        //选中之后大图编辑模式
        ipc.allowsEditing = YES;
        [self presentViewController:ipc animated:YES completion:nil];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alert addAction:lib];
    [alert addAction:capture];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}
#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    UIImage *pickImage = info[UIImagePickerControllerOriginalImage];
    UIImageView *rview = [[UIImageView alloc] initWithImage:pickImage];

            UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, IMG_WIDTH, IMG_WIDTH)];
            view.clipsToBounds = YES;
            [view setContentMode:UIViewContentModeScaleToFill];
        view.image = [self scaleImg:pickImage withSize:CGSizeMake(IMG_WIDTH, IMG_HEIGHT)];
            [self.picture addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.picture).with.offset((self.imageArray.count%3) * IMG_WIDTH);
                make.top.equalTo(self.picture).with.offset((self.imageArray.count/3) * IMG_HEIGHT );
                make.height.mas_greaterThanOrEqualTo(IMG_HEIGHT);
                make.width.mas_equalTo(IMG_WIDTH);
            }];
        [self.imageArray addObject:view];

        [self.picture mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(IMG_HEIGHT * ((self.imageArray.count / 3 ) + 1));
        }];
        [self.addBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.picture).with.offset(IMG_WIDTH * (self.imageArray.count % 3) );
            make.top.equalTo(self.picture).with.offset(IMG_HEIGHT * (self.imageArray.count / 3 ));
            make.height.mas_greaterThanOrEqualTo(IMG_HEIGHT);
            make.width.mas_equalTo(IMG_WIDTH);
            make.bottom.equalTo(self.picture);
            
        }];
//            [self.tableView beginUpdates];
//            [self.tableView endUpdates];
//
//            [self.tableView layoutIfNeeded];
        
    
    [picker dismissViewControllerAnimated:YES completion:nil];
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

-(UIImage *)scaleImg:(UIImage *)img withSize:(CGSize) wannaSize{
    UIImage *orignialImg = img;
    UIGraphicsBeginImageContextWithOptions(wannaSize, false, 0);
    [orignialImg drawInRect:CGRectMake(0, 0, wannaSize.width, wannaSize.height)];
    UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImg;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
