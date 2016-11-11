//
//  ResonsTableView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/11.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "ResonsTableView.h"

@interface ResonsTableView ()<UITableViewDelegate,UITableViewDataSource>
/** 数据 */
@property (strong,nonatomic) NSArray *dataArray;
/** 蒙版 */
@property (strong, nonatomic) UIControl *hudView;

/** 选择的字符串 */
@property (strong, nonatomic) NSString *lastString;
@end

@implementation ResonsTableView

- (NSArray *)dataArray {

    if (!_dataArray) {
        _dataArray = @[@"喜欢其他狗狗",@"不喜欢这只了",@"条件不允许养了",@"运费太贵"];
    }
    return _dataArray;
}

- (UIControl *)hudView
{
    // 蒙版
    if (!_hudView) {
        _hudView = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
        _hudView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    }
    
    return _hudView;
}


- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}
#pragma mark
#pragma mark - tableView代理
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSString * identifer = @"cellID";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        
        cell.textLabel.text = self.dataArray[indexPath.row];
        
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return cell;
}
#pragma mark - 头尾
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        
        label.text = @"请选择原因";
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
        [button setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:(UIControlStateNormal)];
        
        [button setBackgroundColor:[UIColor colorWithHexString:@"#99cc33"]];
        [button addTarget:self action:@selector(dismiss) forControlEvents:(UIControlEventTouchDown)];
        
        return button;
    }
    
    return nil;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *text = self.dataArray[indexPath.row];
    if (_resonBlock) {
        _resonBlock(text);
    }
}
#pragma mark
#pragma mark - 弹出效果
- (void)show
{
    //获取主window
    UIWindow * keyWindow = [[UIApplication sharedApplication] keyWindow];
    //载入蒙版
    [keyWindow addSubview:self.hudView];
    //载入alertView
    [keyWindow addSubview:self];
    
    
    //根据overlayer设置alertView的中心点
    CGRect rect = self.frame;
    rect = CGRectMake(0, SCREEN_HEIGHT - 264, SCREEN_WIDTH, 264);
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
    
    self.hudView.alpha = 0;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.hudView.alpha = 1;
        self.transform = CGAffineTransformIdentity;
    }];
}
- (void)fadeOut
{
    [UIView animateWithDuration:0.3 animations:^{
        self.hudView.alpha = 0;
        self.transform = CGAffineTransformMakeScale(0.3, 0.3);
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        [self.hudView removeFromSuperview];
    }];
}

@end
