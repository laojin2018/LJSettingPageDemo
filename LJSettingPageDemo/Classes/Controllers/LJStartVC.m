//
//  LJStartVC.m
//  LJSettingPageDemo
//
//  Created by lemon on 16/5/20.
//  Copyright © 2016年 jinxicheng. All rights reserved.
//

#import "LJStartVC.h"

@interface LJStartVC ()

@end

@implementation LJStartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏
    UIBarButtonItem *settingItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(jumpToSetting:)];
    self.navigationItem.rightBarButtonItem = settingItem;
}
// MARK: - 跳转到设置页面
- (void)jumpToSetting:(UIBarButtonItem *)sender{
    // 创建设置控制器
    LJSettingVC *settingVC = [[LJSettingVC alloc] init];
    // 为控制配置Plist文件，显示不同内容
    settingVC.plistName = @"LJSettingHome";
    // 跳转
    [self.navigationController pushViewController:settingVC animated:YES];
}


@end
