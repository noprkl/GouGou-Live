//
//  CloseBusinessCell.m
//  GouGou-Live
//
//  Created by ma c on 16/11/15.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "CloseBusinessCell.h"
#import "NicknameView.h"
#import "DogCardView.h"
#import "LogisticsInfoView.h"
#import "CostView.h"
#import "FunctionButtonView.h"

@interface CloseBusinessCell ()
/** 昵称View */
@property (strong,nonatomic) NicknameView *nickView;
/** 横线 */
@property (strong,nonatomic) UIView *lineview1;
/** 狗狗卡片 */
@property (strong,nonatomic) DogCardView *dogCardView;
/** 横线 */
@property (strong,nonatomic) UIView *lineview2;
/** 物流信息 */
@property (strong,nonatomic) LogisticsInfoView *logisticView;
/** 横线 */
@property (strong,nonatomic) UIView *lineview3;
/** 花费 */
@property (strong,nonatomic) CostView *costView;
/** 横线 */
@property (strong,nonatomic) UIView *lineview4;

@end

@implementation CloseBusinessCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.nickView];
        [self.contentView addSubview:self.lineview1];
        [self.contentView addSubview:self.dogCardView];
        [self.contentView addSubview:self.lineview2];
        [self.contentView addSubview:self.logisticView];
        [self.contentView addSubview:self.lineview3];
        [self.contentView addSubview:self.costView];
        [self.contentView addSubview:self.lineview4];
        //        [self.contentView addSubview:self.functionBtn];
    }
    return self;
}


#pragma mark
#pragma mark - 约束
- (void)layoutSubviews {
    
    [super layoutSubviews];
    __weak typeof(self) weakself = self;
    
    
    [_nickView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.right.equalTo(weakself);
        make.height.equalTo(54);
        
    }];
    
    [_lineview1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.nickView.bottom);
        make.left.right.equalTo(weakself);
        make.height.equalTo(1);
        
    }];
    
    [_dogCardView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.lineview1.bottom);
        make.left.right.equalTo(weakself);
        make.height.equalTo(100);
        
    }];
    
    [_lineview2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.dogCardView.bottom);
        make.left.right.equalTo(weakself);
        make.height.equalTo(1);
        
    }];
    
    [_logisticView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.lineview2.bottom);
        make.left.right.equalTo(weakself);
        make.height.equalTo(88);
        
    }];
    
    [_lineview3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.logisticView.bottom);
        make.left.right.equalTo(weakself);
        make.height.equalTo(1);
        
    }];
    
    [_costView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.lineview3.bottom);
        make.left.right.equalTo(weakself);
        make.height.equalTo(44);
    }];
    
    [_lineview4 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.costView.bottom);
        make.left.right.equalTo(weakself);
        make.height.equalTo(1);
        
    }];
    
}

#pragma mark
#pragma mark - 懒加载

- (NicknameView *)nickView {
    
    if (!_nickView) {
        _nickView = [[NicknameView alloc] init];
        [_nickView setStateMessage:@"待付定金"];
    }
    return _nickView;
}

- (UIView *)lineview1 {
    
    if (!_lineview1) {
        _lineview1 = [[UIView alloc] init];
        _lineview1.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _lineview1;
}

- (DogCardView *)dogCardView {
    
    if (!_dogCardView) {
        _dogCardView = [[DogCardView alloc] init];
    }
    return _dogCardView;
}

- (UIView *)lineview2 {
    
    if (!_lineview2) {
        _lineview2 = [[UIView alloc] init];
        _lineview2.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _lineview2;
}

- (LogisticsInfoView *)logisticView {
    
    if (!_logisticView) {
        _logisticView = [[LogisticsInfoView alloc] init];
    }
    return _logisticView;
}

- (UIView *)lineview3 {
    
    if (!_lineview3) {
        _lineview3 = [[UIView alloc] init];
        _lineview3.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _lineview3;
}

- (CostView *)costView {
    
    if (!_costView) {
        _costView = [[CostView alloc] init];
    }
    return _costView;
}

- (UIView *)lineview4 {
    
    if (!_lineview4) {
        _lineview4 = [[UIView alloc] init];
        _lineview4.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _lineview4;
}


- (void)awakeFromNib {
    [super awakeFromNib];
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
