//
//  LJSettingCell.m
//  彩票demo
//
//  Created by lemon on 16/5/17.
//  Copyright © 2016年 jinxicheng. All rights reserved.
//

#import "LJSettingCell.h"

@implementation LJSettingCell

// 创建
+(instancetype)cellWithTableView:(UITableView *)tableView andTableStyle:(UITableViewCellStyle)cellStyle{
    static NSString *ID = @"cell";
    LJSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[LJSettingCell alloc] initWithStyle:cellStyle reuseIdentifier:ID];
    }
    return cell;
}

// 设置数据
- (void)setCellItem:(NSDictionary *)cellItem{
    _cellItem = cellItem;
    // 设置数据
    if ([self.cellItem[LJIcon] length]) {
        self.imageView.image = [UIImage imageNamed:self.cellItem[LJIcon]];
    }
    if ([self.cellItem[LJTitle] length]) {
        self.textLabel.text = self.cellItem[LJTitle];
    }
    
    // 设置辅助视图，是图片或者开关
    NSString *className = cellItem[LJAccessoryType];
    Class accClass = NSClassFromString(className);
    id accObj = nil;
    // 图片
    if ([accClass isSubclassOfClass:[UIImageView class]]) {
        // 创建对象
        UIImage *ima = [UIImage imageNamed:cellItem[LJAccessoryName]];
        accObj = [[accClass alloc] initWithImage:ima];
    }
    // 开关
    else if([accClass isSubclassOfClass:[UISwitch class]]){
        accObj = [[accClass alloc] init];
        UISwitch *swi = accObj;
        // 从偏好设置中获取状态
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if ([cellItem[LJKeyName] length] > 0) {
            
            [swi setOn:[defaults boolForKey:cellItem[LJKeyName]]];
        }
        
        // 给开关添加监听事件
        [accObj addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventValueChanged];
    }
    self.accessoryView = accObj;
    
    if (cellItem[LJCellStyle] == 0) {
        return;
    }
    self.detailTextLabel.text = cellItem[LJSubtitle];
    // 设置子标题的颜色
    if ([cellItem[LJHighLight] boolValue]) {
//        self.detailTextLabel.tintColor = [UIColor redColor];
        self.detailTextLabel.textColor = [UIColor redColor];
    }else{
        self.detailTextLabel.textColor = [UIColor grayColor];

    }

}
// MARK :- 开关的监听事件
- (void)changeAction:(UISwitch *)sender{
    // 存储开关状态
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:sender.isOn forKey:self.cellItem[LJKeyName]];
    [defaults synchronize];
}
@end








