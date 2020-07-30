//
//  PostTableViewController.m
//  HackWeek
//
//  Created by New on 2020/7/29.
//  Copyright © 2020 Godlowd. All rights reserved.
//

#import "PostTableViewController.h"
#import <Masonry.h>
@interface PostTableViewController ()

@end

@implementation PostTableViewController
NSString *postCell = @"postCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
                make.height.mas_equalTo(22);
            }];
            
            [cell addSubview:_postPage];
            [_postPage mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(cell.mas_right).with.offset(-54);
                make.top.equalTo(cell.mas_top).with.offset(52);
                make.height.mas_equalTo(22);
            }];
        }
    }
    else if (indexPath.row == 1){
        for (UIView *subview in cell.subviews) {
            [subview removeFromSuperview];
            UITextField *text = UITextField.new;
            NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc] initWithString:@"请输入标题" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20]}];
            text.attributedPlaceholder = placeholderString;
            [cell addSubview:text];
            [text mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell.mas_left).with.offset(52);
                make.top.equalTo(cell.mas_top).with.offset(52);
                make.bottom.equalTo(cell.mas_bottom).with.offset(-52);
            }];
        }
    }
    else if (indexPath.row == 2){
        for (UIView *subview in cell.subviews) {
            [subview removeFromSuperview];
            UITextField *text = UITextField.new;
            NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc] initWithString:@"请输入正文" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20]}];
            text.attributedPlaceholder = placeholderString;
            [cell addSubview:text];
            [text mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell.mas_left).with.offset(52);
                make.top.equalTo(cell.mas_top).with.offset(52);
                make.bottom.equalTo(cell.mas_bottom).with.offset(-52);
            }];
        }
    }
    // Configure the cell...
    
    return cell;
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
