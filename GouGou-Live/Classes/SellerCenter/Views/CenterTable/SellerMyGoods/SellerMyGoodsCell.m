//
//  SellerMyGoodsCell.m
//  GouGou-Live
//
//  Created by ma c on 16/11/16.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerMyGoodsCell.h"

@interface SellerMyGoodsCell ()


@property(nonatomic, strong) UIButton *selectBtn; /**< 选中按钮 */

@property(nonatomic, strong) UIView *line; /**< 线 */

@property (strong, nonatomic)  UIImageView *dogImageView;/**< 狗狗图片*/
@property (strong, nonatomic)  UILabel *dogNameLabel;/**< 狗狗名字 */
@property (strong, nonatomic) UILabel *kindLabel; /**< 品种 */
@property (strong, nonatomic)  UILabel *dogKindLabel;/**< 狗狗种类 */
@property (strong, nonatomic)  UILabel *dogAgeLabel;/**< 狗狗年龄*/

@property (strong, nonatomic)  UILabel *dogSizeLabel;/**< 狗狗体型*/

@property (strong, nonatomic)  UILabel *dogColorLabel;/**< 狗狗颜色*/

@property (strong, nonatomic)  UILabel *nowPriceLabel;/**< 狗狗价格*/
@property (strong, nonatomic)  UILabel *oldPriceLabel;/**< 狗狗老价格*/

@property (strong, nonatomic)  UILabel *stateLabel;/**< 商品当前状态*/

@property (nonatomic, strong) UIButton *onSailBtn; /**< 上/下架按钮 */

@end

@implementation SellerMyGoodsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.line];
        [self.contentView addSubview:self.dogImageView];
        [self.contentView addSubview:self.selectBtn];
        [self.contentView addSubview:self.dogNameLabel];
        [self.contentView addSubview:self.kindLabel];
        [self.contentView addSubview:self.dogKindLabel];
        [self.contentView addSubview:self.dogAgeLabel];
        [self.contentView addSubview:self.dogSizeLabel];
        [self.contentView addSubview:self.dogColorLabel];
        [self.contentView addSubview:self.nowPriceLabel];
        [self.contentView addSubview:self.oldPriceLabel];
        [self.contentView addSubview:self.stateLabel];
        [self.contentView addSubview:self.onSailBtn];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
   
    [self.line makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top);
        make.left.top.equalTo(self);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, 10));
    }];

    //判断 重新约束
    CGFloat width = 10;
    if (_isMove) {
        width = 45;
    }
    [self.dogImageView remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).offset(width);
        make.top.equalTo(self.line.bottom).offset(10);
        make.size.equalTo(CGSizeMake(78, 78));
    }];
    [self.selectBtn makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.dogImageView.left).offset(-11);
        make.centerY.equalTo(self.dogImageView.centerY);
    }];
    
    [self.dogNameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dogImageView.top).offset(5);
        make.left.equalTo(self.dogImageView.right).offset(10);
    }];
    [self.kindLabel makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.dogNameLabel.bottom);
        make.left.equalTo(self.dogNameLabel.right).offset(10);
    }];
    
    [self.dogKindLabel makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.dogNameLabel.bottom);
        make.left.equalTo(self.kindLabel.right).offset(10);
    }];
    
    [self.dogAgeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dogNameLabel.bottom).offset(7);
        make.left.equalTo(self.dogImageView.right).offset(10);
    }];
    [self.dogSizeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.dogAgeLabel.centerY);
        make.left.equalTo(self.dogAgeLabel.right).offset(10);
    }];
    [self.dogColorLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.dogAgeLabel.centerY);
        make.left.equalTo(self.dogSizeLabel.right).offset(10);
    }];
    [self.nowPriceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dogAgeLabel.bottom).offset(0);
        make.left.equalTo(self.dogImageView.right).offset(10);
    }];
    [self.oldPriceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nowPriceLabel.bottom);
        make.left.equalTo(self.dogImageView.right).offset(10);
    }];
    [self.stateLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(15);
        make.right.equalTo(self.right).offset(-10);
    }];
    
    [self.onSailBtn makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottom).offset(-10);
        make.right.equalTo(self.right).offset(-10);
        make.size.equalTo(CGSizeMake(60, 25));
    }];
    
}

#pragma mark
#pragma mark - Action
- (void)clickSelectBtnAction:(UIButton *)btn {

    if (_selectBlock) {
        _selectBlock(btn);
    }
}
// 通过判断多选按钮是否隐藏来设置图片的位置的
- (void)setIsMove:(BOOL)isMove {
    _isMove = isMove;
}

- (void)setIsBtnSelect:(BOOL)isBtnSelect {
    _isBtnSelect = isBtnSelect;
    self.selectBtn.selected = isBtnSelect;
}

- (void)setModel:(SellerMyGoodsModel *)model {
    _model = model;
    self.dogAgeLabel.text = model.ageName;
    if (model.pathSmall != NULL) {
        NSString *urlString = [IMAGE_HOST stringByAppendingString:model.pathSmall];
        [self.dogImageView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"组-7"]];
    }
    
    self.dogNameLabel.text = model.name;
    self.dogKindLabel.text = model.kindName;
    self.dogAgeLabel.text = model.ageName;
    self.dogSizeLabel.text = model.sizeName;
    self.dogColorLabel.text = model.colorName;
    self.oldPriceLabel.attributedText = [NSAttributedString getCenterLineWithString:[NSString stringWithFormat:@"￥%@", model.priceOld]];
    self.nowPriceLabel.text = [NSString stringWithFormat:@"￥%@", model.price];
    // 判断状态
    NSString *state = @"";
    if ([model.status isEqualToString:@"1"]) {// 1：新建商品 2：审核未通过  3：上线 4：下线5：售完
        state = @"审核中";
    }else if ([model.status isEqualToString:@"2"]) {
        state = @"审核未通过";
    }else if ([model.status isEqualToString:@"3"]) {
        state = @"待售";
        [self.onSailBtn setTitle:@"下架" forState:(UIControlStateNormal)];
        self.onSailBtn.hidden = NO;
    }else if ([model.status isEqualToString:@"4"]) {
        state = @"已预订";
        [self.onSailBtn setTitle:@"上架" forState:(UIControlStateNormal)];
        self.onSailBtn.hidden = NO;
    }else if ([model.status isEqualToString:@"5"]) {
        state = @"已售";
        [self.onSailBtn setTitle:@"上架" forState:(UIControlStateNormal)];
        self.onSailBtn.hidden = NO;
    }
    self.stateLabel.text = state;
}
#pragma mark
#pragma mark - 懒加载
- (UIButton *)selectBtn {
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        // 设置tag 方便取出来
        _selectBtn.tag = 1000;
        [_selectBtn setImage:[UIImage imageNamed:@"椭圆-1"] forState:(UIControlStateNormal)];
        [_selectBtn setImage:[UIImage imageNamed:@"圆角-对勾"] forState:(UIControlStateSelected)];
        [_selectBtn addTarget:self action:@selector(clickSelectBtnAction:) forControlEvents:(UIControlEventTouchDown)];
    }
    return _selectBtn;
}
- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _line;
}
- (UIImageView *)dogImageView {
    if (!_dogImageView) {
        _dogImageView = [[UIImageView alloc] init];
        _dogImageView.image = [UIImage imageNamed:@"组-7"];
        
        _dogImageView.layer.cornerRadius = 5;
        _dogImageView.layer.masksToBounds = YES;
    }
    return _dogImageView;
}
- (UILabel *)dogNameLabel {
    if (!_dogNameLabel) {
        _dogNameLabel = [[UILabel alloc] init];
        
        _dogNameLabel.text = @"豆豆";
        _dogNameLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _dogNameLabel.font = [UIFont boldSystemFontOfSize:16];
        
    }
    return _dogNameLabel;
}
- (UILabel *)kindLabel {
    if (!_kindLabel) {
        _kindLabel = [[UILabel alloc] init];
        
        _kindLabel.text = @"品种";
        _kindLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _kindLabel.font = [UIFont systemFontOfSize:12];
    }
    return _kindLabel;
}
- (UILabel *)dogKindLabel {
    if (!_dogKindLabel) {
        _dogKindLabel = [[UILabel alloc] init];
        
        _dogKindLabel.text = @"拉布拉多";
        _dogKindLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _dogKindLabel.font = [UIFont systemFontOfSize:12];
        
    }
    return _dogKindLabel;
}
- (UILabel *)dogAgeLabel {
    if (!_dogAgeLabel) {
        _dogAgeLabel = [[UILabel alloc] init];
        
        _dogAgeLabel.text = @"6个月";
        _dogAgeLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _dogAgeLabel.font = [UIFont systemFontOfSize:12];
    }
    return _dogAgeLabel;
}
- (UILabel *)dogSizeLabel {
    if (!_dogSizeLabel) {
        _dogSizeLabel = [[UILabel alloc] init];
        
        _dogSizeLabel.text = @"大型犬";
        _dogSizeLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _dogSizeLabel.font = [UIFont systemFontOfSize:12];
    }
    return _dogSizeLabel;
}
- (UILabel *)dogColorLabel {
    if (!_dogColorLabel) {
        _dogColorLabel = [[UILabel alloc] init];
        
        _dogColorLabel.text = @"白色";
        _dogColorLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _dogColorLabel.font = [UIFont systemFontOfSize:12];
    }
    return _dogColorLabel;
}
- (UILabel *)nowPriceLabel {
    if (!_nowPriceLabel) {
        _nowPriceLabel = [[UILabel alloc] init];
        
        _nowPriceLabel.text = @"¥ 1400";
        _nowPriceLabel.textColor = [UIColor colorWithHexString:@"#ffa11a"];
        _nowPriceLabel.font = [UIFont systemFontOfSize:18];
    }
    return _nowPriceLabel;
}
- (UILabel *)oldPriceLabel {
    if (!_oldPriceLabel) {
        _oldPriceLabel = [[UILabel alloc] init];
        
        _oldPriceLabel.attributedText = [NSAttributedString getCenterLineWithString:@"¥ 2400"];
    }
    return _oldPriceLabel;
}
- (UILabel *)stateLabel {
    
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc] init];
        
        _stateLabel.text = @"新建商品";
        _stateLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _stateLabel.font = [UIFont systemFontOfSize:12];
    }
    return _stateLabel;
}
- (UIButton *)onSailBtn {
    if (!_onSailBtn) {
        _onSailBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_onSailBtn setTitle:@"下架" forState:(UIControlStateNormal)];
        [_onSailBtn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:(UIControlStateNormal)];
        _onSailBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _onSailBtn.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        
        _onSailBtn.layer.cornerRadius = 5;
        _onSailBtn.layer.masksToBounds = YES;
        _onSailBtn.layer.borderColor = [UIColor colorWithHexString:@"#666666"].CGColor;
        _onSailBtn.layer.borderWidth = 1;
        
        [_onSailBtn addTarget:self action:@selector(clickOnSailBtnDown:) forControlEvents:(UIControlEventTouchDown)];
        
    }
    return _onSailBtn;
}
- (void)clickOnSailBtnDown:(UIButton *)btn {
    _onSailBtn.layer.borderColor = [UIColor colorWithHexString:@"#99cc33"].CGColor;
    _onSailBtn.backgroundColor = [UIColor colorWithHexString:@"#99cc33"];
    [_onSailBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(clickOnSailBtnUpInsaid:) forControlEvents:(UIControlEventTouchUpInside)];
}
- (void)clickOnSailBtnUpInsaid:(UIButton *)btn {
    _onSailBtn.layer.borderColor = [UIColor colorWithHexString:@"#666666"].CGColor;
    _onSailBtn.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    [_onSailBtn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:(UIControlStateNormal)];
    if (_onSailBlock) {
        _onSailBlock([btn currentTitle]);
    }
}

@end
