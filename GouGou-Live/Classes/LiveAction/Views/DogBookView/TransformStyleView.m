//
//  TransformStyleView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/4.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "TransformStyleView.h"

@interface TransformStyleView ()<UITableViewDataSource, UITableViewDelegate>
/** 蒙版 */
@property (strong, nonatomic) UIControl *overLayer;

/** 数据 */
@property (strong, nonatomic) NSArray *dataPlist;

/** 上一个按钮 */
@property (strong, nonatomic) UIButton *lastBtn;

@property(nonatomic, strong) NSMutableArray *buttons; /**< 按钮数组 */

@property(nonatomic, assign) NSInteger lastIndex; /**< 上一个选中的按钮的位置 */


@end
static NSString *cellid = @"SizeFilterCellID";
@implementation TransformStyleView
#pragma mark
#pragma mark - TableView 代理

- (NSArray *)dataPlist {
    if (!_dataPlist) {
        
        _dataPlist = @[@"免运费："];
    }
    return _dataPlist;
}
- (void)setDetailPlist:(NSArray *)detailPlist {
    _detailPlist = detailPlist;
}
- (NSMutableArray *)buttons {
    if (!_buttons) {
        _buttons = [NSMutableArray  array];
    }
    return _buttons;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataPlist.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:cellid];
    }
    
    cell.textLabel.text = self.dataPlist[indexPath.row];
    cell.detailTextLabel.text = self.detailPlist[indexPath.row];

    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btn setImage:[UIImage imageNamed:@"椭圆-1"] forState:(UIControlStateNormal)];
    [btn sizeToFit];
    [btn setImage:[UIImage imageNamed:@"圆角-对勾"] forState:(UIControlStateSelected)];
    [btn addTarget:self action:@selector(choseTransformBtn:) forControlEvents:(UIControlEventTouchDown)];
    [self.buttons addObject:btn];
    if (indexPath.row == 0) {
        self.lastBtn = btn;
        self.lastIndex = 0;
        btn.selected = YES;
    }
    cell.accessoryView = btn;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
    
}
- (void)choseTransformBtn:(UIButton *)btn {
    
    
    
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
        
        label.text = @"运费选择";
        label.textAlignment = NSTextAlignmentCenter;
        
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
        [button setTitle:@"确认" forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:(UIControlStateNormal)];
        
        [button setBackgroundColor:[UIColor colorWithHexString:@"#99cc33"]];
        [button addTarget:self action:@selector(clickSureBtnAction) forControlEvents:(UIControlEventTouchDown)];
        
        return button;
    }
    
    return nil;
    
}
- (void)clickSureBtnAction {
    if (_transformCellBlock) {
        [self dismiss];
        _transformCellBlock(self.detailPlist[self.lastIndex]);
    }
}
#pragma mark 选中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIButton *btn = (UIButton *)self.buttons[indexPath.row];
    self.lastBtn.selected = NO;
    
    btn.selected = YES;
    self.lastBtn = btn;
    self.lastIndex = indexPath.row;
}

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
    CGFloat height = (self.dataPlist.count + 2) * 44;
    rect = CGRectMake(0, SCREEN_HEIGHT - height, SCREEN_WIDTH, height);
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
@end
