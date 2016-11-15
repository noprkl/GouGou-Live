//
//  WaitConsignmentCell.m
//  GouGou-Live
//
//  Created by ma c on 16/11/15.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "WaitConsignmentCell.h"

#import "NicknameView.h"
#import "DogCardView.h"
#import "CostView.h"
#import "FunctionButtonView.h"

@interface WaitConsignmentCell ()
/** 昵称View */
@property (strong,nonatomic) NicknameView *nickView;
/** 横线 */
@property (strong,nonatomic) UIView *lineview1;
/** 狗狗卡片 */
@property (strong,nonatomic) DogCardView *dogCardView;
/** 横线 */
@property (strong,nonatomic) UIView *lineview2;
/** 花费 */
@property (strong,nonatomic) CostView *costView;
/** 横线 */
@property (strong,nonatomic) UIView *lineview3;
/** 功能按钮 */
//@property (strong,nonatomic) FunctionButtonView *functionBtn;

@end

@implementation WaitConsignmentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.nickView];
        [self.contentView addSubview:self.lineview1];
        [self.contentView addSubview:self.dogCardView];
        [self.contentView addSubview:self.lineview2];
        [self.contentView addSubview:self.costView];
        [self.contentView addSubview:self.lineview3];
        
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
    
    
    [_costView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.lineview2.bottom);
        make.left.right.equalTo(weakself);
        make.height.equalTo(44);
    }];
    
    [_lineview3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
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
        [_nickView setStateMessage:@"待发货"];
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

- (CostView *)costView {
    
    if (!_costView) {
        _costView = [[CostView alloc] init];
    }
    return _costView;
}

- (UIView *)lineview3 {
    
    if (!_lineview3) {
        _lineview3 = [[UIView alloc] init];
        _lineview3.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _lineview3;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
