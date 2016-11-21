//
//  SellerShipTemplateView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/20.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerShipTemplateView.h"

@interface SellerShipTemplateView ()<UITableViewDataSource, UITableViewDelegate>
/** 蒙版 */
@property (strong, nonatomic) UIControl *overLayer;

/** 数据 */
@property (strong, nonatomic) NSArray *dataPlist;

/** 上一个按钮 */
@property (strong, nonatomic) UIButton *lastBtn;

@property(nonatomic, strong) NSMutableArray *buttons; /**< 按钮数组 */

@property(nonatomic, assign) NSInteger lastIndex; /**< 上一个选中的按钮的位置 */


@end
static NSString *cellid = @"SellerShipTemplate";
@implementation SellerShipTemplateView
#pragma mark
#pragma mark - TableView 代理

- (NSArray *)dataPlist {
    if (!_dataPlist) {
        _dataPlist = [NSArray array];
        _dataPlist = @[@"运费模板一", @"运费模板二", @"运费模板三"];
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
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    UIImage *image = [UIImage imageNamed:@"椭圆-1"];
    [btn setImage:image forState:(UIControlStateNormal)];
    btn.frame = CGRectMake(10 , (44 - image.size.height) / 2, image.size.width, image.size.height);
    
    [btn setImage:[UIImage imageNamed:@"圆角-对勾"] forState:(UIControlStateSelected)];
    [btn addTarget:self action:@selector(choseTransformBtn:) forControlEvents:(UIControlEventTouchDown)];
    [self.buttons addObject:btn];
    if (indexPath.row == 0) {
        self.lastBtn = btn;
        self.lastIndex = 0;
        btn.selected = YES;
    }
    [cell.contentView addSubview:btn];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(image.size.width + 20, 0, 200, 44)];
    label.text = self.dataPlist[indexPath.row];
    label.textColor = [UIColor colorWithHexString:@"#999999"];
    label.font = [UIFont systemFontOfSize:14];
    [cell.contentView addSubview:label];
    
    cell.detailTextLabel.attributedText = [self getAttributeWith:self.detailPlist[indexPath.row]];
    return cell;
    
}
- (void)choseTransformBtn:(UIButton *)btn {
    
    
    
}

// 富文本
- (NSAttributedString *)getAttributeWith:(NSString *)string{
    NSAttributedString *attribut = [[NSAttributedString alloc] initWithString:string attributes:@{
                                                                                                  NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#000000"],
                                                                                                  NSFontAttributeName:[UIFont systemFontOfSize:16]
                                                                                                  }];
    return attribut;
}
#pragma mark 高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 49;
}
#pragma mark 头尾
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        
        label.text = @"运费设置";
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
        button.frame = CGRectMake(0, 0, SCREEN_WIDTH, 49);
        [button setTitle:@"确认" forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:(UIControlStateNormal)];
        
        [button setBackgroundColor:[UIColor colorWithHexString:@"#99cc33"]];
        [button addTarget:self action:@selector(clickSureBtnAction) forControlEvents:(UIControlEventTouchDown)];
        
        return button;
    }
    
    return nil;
    
}
- (void)clickSureBtnAction {
    if (_sureBlock) {
        [self dismiss];
        _sureBlock(self.detailPlist[self.lastIndex]);
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
    rect = CGRectMake(0, SCREEN_HEIGHT - 180, SCREEN_WIDTH, 180);
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
