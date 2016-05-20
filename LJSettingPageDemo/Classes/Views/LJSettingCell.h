//
//  LJSettingCell.h
//  彩票demo
//
//  Created by lemon on 16/5/17.
//  Copyright © 2016年 jinxicheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJSettingCell : UITableViewCell
// 数据
@property (strong, nonatomic) NSDictionary  *cellItem;

+ (instancetype)cellWithTableView:(UITableView *)tableView andTableStyle:(UITableViewCellStyle )cellStyle;
@end
