//
//  PayMoneyPrompt.m
//  GouGou-Live
//
//  Created by ma c on 16/11/15.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "PayMoneyPrompt.h"
#import "PromptView.h"
#import "PaySuccessViewController.h"
#import "NSString+MD5Code.h"

@interface PayMoneyPrompt ()<UITableViewDataSource, UITableViewDelegate>

/** 蒙版 */
@property (strong, nonatomic) UIControl *hudView;

/** 数据 */
@property (strong, nonatomic) NSArray *dataPlist;

/** 选择的字符串 */
@property (strong, nonatomic) NSString *lastString;

@end

static NSString *cellid = @"SizeFilterCellID";

@implementation PayMoneyPrompt

- (UIControl *)hudView
{
    // 懒加载 蒙版
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
    [keyWindow addSubview:self.hudView];
    //载入alertView
    [keyWindow addSubview:self];
    
    
    //根据overlayer设置alertView的中心点
    CGRect rect = self.frame;
    rect = CGRectMake(0, SCREEN_HEIGHT - 44 * self.dataArr.count, SCREEN_WIDTH, 44 * self.dataArr.count);
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
}
- (void)setPayMoney:(NSString *)payMoney {
    _payMoney = payMoney;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataPlist.count - 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:cellid];
    }
    
    cell.textLabel.text = self.dataPlist[indexPath.row + 1];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
        
        cell.detailTextLabel.text = [NSString stringWithFormat:@"￥%@", _payMoney];
        
    } else if (indexPath.row == 1) {
        
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
    } else if (indexPath.row == 2) {
        
        cell.detailTextLabel.text = [NSString stringWithFormat:@"可用余额: %.2f",7360.00];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    } else {
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    

    
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
        
        label.text = [self.dataPlist firstObject];
        label.textAlignment = NSTextAlignmentCenter;
        
        // 线
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 43, SCREEN_WIDTH, 1)];
        line.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
        label.textColor = [UIColor colorWithHexString:@"#333333"];
        [label addSubview:line];
        
        return label;
    }
    
    return nil;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 0) {
        
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        button.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
        [button setTitle:[self.dataPlist lastObject] forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:(UIControlStateNormal)];
        
        [button setBackgroundColor:[UIColor colorWithHexString:@"#99cc33"]];
        [button addTarget:self action:@selector(clickFooterBtnAction) forControlEvents:(UIControlEventTouchDown)];
        
        return button;
    }
    
    return nil;
    
}
- (void)clickFooterBtnAction {
    [self dismiss];
}

#pragma mark 选中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *text = self.dataPlist[indexPath.row + 1];
    self.lastString = text;
   
    if (indexPath.row < 2) {
        
        return;
    } else {
        if (_payCellBlock) {
            _payCellBlock(text);
        }       
        [self dismiss];
    }
}

//- (BaseViewController *)viewController {
//    for (UIView* next = [self superview]; next; next = next.superview) {
//        UIResponder *nextResponder = [next nextResponder];
//        if ([nextResponder isKindOfClass:[BaseViewController class]]) {
//            return (BaseViewController *)nextResponder;
//        }
//    }
//    return nil;
//}

@end
