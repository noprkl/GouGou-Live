//
//  ChosePayStyleView.m
//  GouGou-Live
//
//  Created by Huimor on 16/12/7.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "ChosePayStyleView.h"

@interface ChosePayStyleView () <UITableViewDataSource, UITableViewDelegate>

/** 蒙版 */
@property (strong, nonatomic) UIControl *overLayer;

/** 数据 */
@property (strong, nonatomic) NSArray *dataPlist;

/** 选择的字符串 */
@property (strong, nonatomic) NSString *lastString;

@end

static NSString *cellid = @"ChosePayStyleView";

@implementation ChosePayStyleView

- (UIControl *)overLayer
{
    // 懒加载 蒙版
    if (!_overLayer) {
        _overLayer = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
        _overLayer.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        [_overLayer addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _overLayer;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.separatorColor = [UIColor colorWithHexString:@"#e0e0e0"];
        self.bounces = NO;
        
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
    rect = CGRectMake(0, SCREEN_HEIGHT - 44 * (self.dataArr.count + 2), SCREEN_WIDTH, 44 * (self.dataArr.count + 2));
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

- (void)setTitle:(NSString *)title {
    _title = title;
    [self reloadData];
    
}
#pragma mark
#pragma mark - TableView 代理

- (NSArray *)dataPlist {
    if (!_dataPlist) {
        
        _dataPlist = [NSArray array];
    }
    return _dataPlist;
}
- (void)setDataArr:(NSArray *)dataArr {
    _dataArr = dataArr;
    _dataPlist = dataArr;
    [self reloadData];
    self.lastString = self.dataArr[0];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataPlist.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid];
    }
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    label.textColor = [UIColor blackColor];
    cell.backgroundColor = [UIColor whiteColor];
    label.text = self.dataArr[indexPath.row];
    label.textColor = [UIColor colorWithHexString:@"666666"];
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:label];
    
    return cell;
    
}
#pragma mark 高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 44;
}
#pragma mark 头尾
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        
        label.text = self.title;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor colorWithHexString:@"#666666"];
        label.font = [UIFont systemFontOfSize:16];
        // 线
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 43, SCREEN_WIDTH, 1)];
        line.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
        [label addSubview:line];
        
        return label;
    }
    
    return nil;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 0) {
        
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        button.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
        [button setTitle:@"确定" forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:(UIControlStateNormal)];
        
        [button setBackgroundColor:[UIColor colorWithHexString:@"#99cc33"]];
        [button addTarget:self action:@selector(clickFooterBtnAction) forControlEvents:(UIControlEventTouchDown)];
        
        return button;
    }
    
    return nil;
    
}
- (void)clickFooterBtnAction {
    [self dismiss];
    
    if (_bottomBlock) {
        _bottomBlock(self.lastString);
    }
}

#pragma mark 选中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.lastString = self.dataPlist[indexPath.row];
    if (_sizeCellBlock) {
        //        [self dismiss];
        _sizeCellBlock(self.lastString);
    }
}
@end
