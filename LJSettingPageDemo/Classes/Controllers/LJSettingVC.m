//
//  LJSettingVC.m
//  彩票demo
//
//  Created by lemon on 16/5/17.
//  Copyright © 2016年 jinxicheng. All rights reserved.
//

#import "LJSettingVC.h"

@interface LJSettingVC ()
@property (strong, nonatomic) NSArray  *groupModel;

@end

@implementation LJSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (instancetype)init
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

#pragma mark - 实现数据源方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.groupModel.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 组
    NSDictionary *groupDict = self.groupModel[section];
    // 行
    NSArray *rowArr = groupDict[LJItems];
    return rowArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // 获取数据
    NSDictionary *dict = self.groupModel[indexPath.section];
    NSArray *Items = dict[LJItems];
    NSDictionary *cellItem = Items[indexPath.row];
    // 创建cell
    LJSettingCell *cell = [LJSettingCell cellWithTableView:tableView andTableStyle:[self getCellStyle:cellItem]];
    // 设置数据
    cell.cellItem = cellItem;
    // 返回cell
    return cell;
}
// 显示头尾
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSDictionary *dict = self.groupModel[section];
    return dict[LJHeader];
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    NSDictionary *dict  = self.groupModel[section];
    return dict[LJFooter];
}
// MARK: - 选中某一行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 取消cell的选中效果啊
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // 获取数据
    NSDictionary *dict = self.groupModel[indexPath.section];
    NSArray *Items = dict[LJItems];
    NSDictionary *cellItem = Items[indexPath.row];
    // 判断时候有要执行的方法
    if ([cellItem[LJFuncName] length] > 0) {
        // 根据字符串生成方法
        SEL funcName = NSSelectorFromString(cellItem[LJFuncName]);
        // 执行方法
        if ([self respondsToSelector:funcName]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self performSelector:funcName];

#pragma clang diagnostic pop
        }
    }
    // 判断是否有目标控制器
    if ([cellItem[LJTargetVc] length] == 0) {
        return;
    }
    
    // 创建目标控制器，如果是Setting，需要配置plist文件，如果不是直接push
    NSString *className = cellItem[LJTargetVc];
    Class targetClass = NSClassFromString(className);
    id obj = [[targetClass alloc]init];
    if ([targetClass isSubclassOfClass:[LJSettingVC class]]) {
        // 创建
        LJSettingVC *targetVC = obj;
        targetVC.plistName = cellItem[LJPlistName];
    }
    // 如果不是设置控制器，则直接跳转
    [self.navigationController pushViewController:obj animated:YES];
    
    
}

// 懒加载数组，根据传入的plist文件在显示不同内容，实现控制器的复用
- (NSArray *)groupModel{
    if (_groupModel == nil) {
        _groupModel = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:self.plistName ofType:@"plist"]];
    }
    return _groupModel;
}

// 获取cell的样式
- (UITableViewCellStyle)getCellStyle:(NSDictionary *)item{
    UITableViewCellStyle style = UITableViewCellStyleDefault;
    if ([item[LJCellStyle] isEqualToString:@"UITableViewCellStyleSubtitle"]) {
        
        style = UITableViewCellStyleSubtitle;
    } else if([item[LJCellStyle] isEqualToString:@"UITableViewCellStyleValue1"]) {
        
        style = UITableViewCellStyleValue1;
    } else if([item[LJCellStyle] isEqualToString:@"UITableViewCellStyleValue2"]) {
        
        style = UITableViewCellStyleValue2;
    }
    return style;
}
@end







