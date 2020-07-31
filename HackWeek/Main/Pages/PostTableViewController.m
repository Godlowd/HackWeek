//
//  PostTableViewController.m
//  HackWeek
//
//  Created by New on 2020/7/29.
//  Copyright © 2020 Godlowd. All rights reserved.
//

#import "PostTableViewController.h"
#import <Masonry.h>
#import "CustomImageVIew.h"
#define IMG_WIDTH 100
#define IMG_HEIGHT IMG_WIDTH
@interface PostTableViewController ()

@end

@implementation PostTableViewController
NSString *postCell = @"postCell";
NSString *placeholder = @"请输入正文";
//-(void)viewWillAppear:(BOOL)animated{
//    self.customimageview = [[CustomImageVIew alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 50)];
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.imageArray = NSMutableArray.new;
    _cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancel setTitle:@"取消" forState:UIControlStateNormal];
    [_cancel setTitleColor:[self colorWithHexString:@"435b5c"] forState:UIControlStateNormal];
    
    _postPage = [UIButton buttonWithType:UIButtonTypeCustom];
    [_postPage setTitle:@"发布" forState:UIControlStateNormal];
    [_postPage setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:postCell];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row == 0) {
//        return 108;
//    }
//    else if(indexPath.row == 1){
//        return 80;
//    }
//    else {
//        return 80;
//    }
//}
#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    UIImage *pickImage = info[UIImagePickerControllerOriginalImage];
    UIImageView *view = [[UIImageView alloc] initWithImage:pickImage];
    for (UITableViewCell *cell in self.tableView.visibleCells) {
        if (cell.tag == 2) {
            UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, IMG_WIDTH, IMG_WIDTH)];
            view.clipsToBounds = YES;
            [view setContentMode:UIViewContentModeScaleToFill];
        view.image = [self scaleImg:pickImage withSize:CGSizeMake(IMG_WIDTH, IMG_HEIGHT)];
            [self.customimageview addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.customimageview).with.offset((self.imageArray.count%3) * IMG_WIDTH);
                make.top.equalTo(self.customimageview).with.offset((self.imageArray.count/3) * IMG_HEIGHT );
                make.height.mas_greaterThanOrEqualTo(IMG_HEIGHT);
                make.width.mas_equalTo(IMG_WIDTH);
            }];
        [self.imageArray addObject:view];

        [self.customimageview mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(IMG_HEIGHT * ((self.imageArray.count / 3 ) + 1));
        }];
        [self.addBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.customimageview).with.offset(IMG_WIDTH * (self.imageArray.count % 3) );
            make.top.equalTo(self.customimageview).with.offset(IMG_HEIGHT * (self.imageArray.count / 3 ));
            make.height.mas_greaterThanOrEqualTo(IMG_HEIGHT);
            make.width.mas_equalTo(IMG_WIDTH);
            make.bottom.equalTo(self.customimageview);
            
        }];
            [self.tableView beginUpdates];
            [self.tableView endUpdates];

            [self.tableView layoutIfNeeded];
        }
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//缩放图片
-(UIImage *)scaleImg:(UIImage *)img withSize:(CGSize) wannaSize{
    UIImage *orignialImg = img;
    UIGraphicsBeginImageContextWithOptions(wannaSize, false, 0);
    [orignialImg drawInRect:CGRectMake(0, 0, wannaSize.width, wannaSize.height)];
    UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImg;
}
#pragma mark - click func
-(void)cancelPost{
    [self dismissViewControllerAnimated:YES completion:nil];
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
#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITextViewDelegate
-(void)textViewDidBeginEditing:(UITextView *)textView{
    if([textView.text isEqualToString:placeholder]){
        textView.text=@"";
        textView.textColor=[UIColor blackColor];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if(textView.text.length < 1){
        textView.text = placeholder;
        textView.textColor = [UIColor grayColor];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:postCell forIndexPath:indexPath];
    if (indexPath.row == 0) {
        for (UIView *subview in cell.subviews) {
            [subview removeFromSuperview];
            [cell addSubview:_cancel];
            [_cancel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell.mas_left).with.offset(51);
                make.top.equalTo(cell.mas_top).with.offset(52);
                make.bottom.equalTo(cell.mas_bottom).with.offset(-52);
//                make.height.mas_equalTo(22);
            }];
            [_cancel addTarget:self action:@selector(cancelPost) forControlEvents:UIControlEventTouchUpInside];
            
            [cell addSubview:_postPage];
            [_postPage mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(cell.mas_right).with.offset(-54);
                make.top.equalTo(cell.mas_top).with.offset(52);
               make.bottom.equalTo(cell.mas_bottom).with.offset(-52);
            }];
        }
    }
    else if (indexPath.row == 1){
        for (UIView *subview in cell.subviews) {
            [subview removeFromSuperview];
            UITextField *text = UITextField.new;
            NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc] initWithString:@"请输入标题" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]}];
            text.attributedPlaceholder = placeholderString;
            text.font = [UIFont systemFontOfSize:20];
            [cell addSubview:text];
            [text mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell.mas_left).with.offset(52);
                make.top.equalTo(cell.mas_top).with.offset(12);
                make.bottom.equalTo(cell.mas_bottom).with.offset(-12);
            }];
        }
    }
    else if (indexPath.row == 2){
        cell.tag = 2;
        for (UIView *subview in cell.subviews) {
            [subview removeFromSuperview];
        }
        UITextView *text = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 30)];;
        text.backgroundColor = UIColor.whiteColor;
        text.delegate = self;
        text.text = @"请输入正文";
        [cell addSubview:text];
        text.font = [UIFont systemFontOfSize:20];
        text.scrollEnabled = false;
        [text mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.mas_left).with.offset(52);
            make.right.equalTo(cell.mas_right).with.offset(-52);
            make.top.equalTo(cell);
            make.height.mas_greaterThanOrEqualTo(100);
        }];
        self.customimageview = [[CustomImageVIew alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 50)];
        [cell addSubview:self.customimageview];
        [self.customimageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(text.mas_bottom);
            make.left.and.right.equalTo(text);
            make.bottom.equalTo(cell);
            make.height.mas_greaterThanOrEqualTo(124);
        }];
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn setImage:[UIImage imageNamed:@"上传图片"] forState:UIControlStateNormal];
        [self.customimageview addSubview:_addBtn];
        [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.customimageview).with.offset(IMG_WIDTH * (self.imageArray.count % 3) );
            make.top.equalTo(self.customimageview).with.offset(IMG_HEIGHT * (self.imageArray.count / 3 ));
            make.bottom.equalTo(self.customimageview).with.offset(-10);
        }];
        [_addBtn addTarget:self action:@selector(upLoadFile) forControlEvents:UIControlEventTouchUpInside];
    }
    // Configure the cell...
    
    return cell;
}
# pragma mark set Color
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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
