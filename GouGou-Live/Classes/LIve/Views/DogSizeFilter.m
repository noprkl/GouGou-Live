//
//  DogSizeFilter.m
//  GouGou-Live
//
//  Created by ma c on 16/10/27.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "DogSizeFilter.h"

@interface DogSizeFilter ()<UITableViewDataSource, UITableViewDelegate>

/** 蒙版 */
@property (strong, nonatomic) UIControl *overLayer;

/** TableView */
@property (strong, nonatomic) UITableView *tableView;
/** 数据 */
@property (strong, nonatomic) NSArray *dataPlist;


/** 选择的字符串 */
@property (strong, nonatomic) NSString *lastString;

@end

static NSString *cellid = @"SizeFilterCellID";

@implementation DogSizeFilter

- (UIControl *)overLayer
{
    // 懒加载 蒙版
    if (!_overLayer) {
        _overLayer = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
        _overLayer.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
//        [_overLayer addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _overLayer;
}

//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        
//        self.backgroundColor = [UIColor orangeColor];
//    }
//    return self;
//}
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.bounces = NO;
        self.dataSource = self;
        self.delegate = self;

       
    }
    return self;
}
#pragma mark
#pragma mark - 弹出效果
- (void)show
{
    //获取主window
    UIWindow * keyWindow = [[UIApplication sharedApplication] keyWindow];
    //载入蒙版
    [keyWindow addSubview:self.overLayer];
    //载入alertView
    [keyWindow addSubview:self];

    
    //根据overlayer设置alertView的中心点
    CGRect rect = self.frame;
    rect = CGRectMake(0, SCREEN_HEIGHT - 260, SCREEN_WIDTH, 260);
    self.frame = rect;
    //渐入动画
    [self fadeIn];
    
}
- (void)dismiss
{
    //返回时调用
    [self fadeOut];
}
- (void)fadeIn
{
    self.transform = CGAffineTransformMakeScale(0.3, 0.3);
   
    self.overLayer.alpha = 0;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.overLayer.alpha = 1;
        self.transform = CGAffineTransformIdentity;
    }];
}
- (void)fadeOut
{
    [UIView animateWithDuration:0.3 animations:^{
        self.overLayer.alpha = 0;
        self.transform = CGAffineTransformMakeScale(0.3, 0.3);
    
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        [self.overLayer removeFromSuperview];
    }];
}

#pragma mark
#pragma mark - TableView 代理
//- (UITableView *)tableView {
//    if (!_tableView) {
//        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:(UITableViewStylePlain)];
//        
//        _tableView.tableFooterView = [[UIView alloc] init];
//        
//        _tableView.delegate = self;
//        _tableView.dataSource = self;
//        
//        _tableView.backgroundColor = [UIColor greenColor];
//        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellid];
//        
//    }
//    return _tableView;
//}
- (NSArray *)dataPlist {
    if (!_dataPlist) {
        
        _dataPlist = @[@"大型犬", @"中型犬", @"小型犬", @"不限"];
    }
    return _dataPlist;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataPlist.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid];
    }
    
    NSString *text = self.dataPlist[indexPath.row];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    label.textColor = [UIColor blackColor];
    cell.backgroundColor = [UIColor whiteColor];
    label.text = text;
    label.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:label];
    
    return cell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 44;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        
        label.text = @"体型";
        label.textAlignment = NSTextAlignmentCenter;
        return label;
    }
    
    return nil;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 0) {
        
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        button.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
        [button setTitle:@"确认" forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:(UIControlStateNormal)];
        
        [button setBackgroundColor:[UIColor colorWithHexString:@"#99cc33"]];
        [button addTarget:self action:@selector(dismiss) forControlEvents:(UIControlEventTouchDown)];

        return button;
    }
    
    return nil;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
     NSString *text = self.dataPlist[indexPath.row];
    if (_sizeCellBlock) {
        _sizeCellBlock(text);
    }
}
@end
