//
//  AddDogShowCell.m
//  GouGou-Live
//
//  Created by ma c on 16/12/8.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "AddDogShowCell.h"

@interface AddDogShowCell ()
/** 我的狗狗状态 */
@property (strong,nonatomic) UILabel *dogStateTitle;
/** 狗狗图片*/
@property (strong, nonatomic)  UIImageView *dogImageView;
/** 狗狗名字 */
@property (strong, nonatomic)  UILabel *dogNameLabel;
/** 品种 */
@property(nonatomic, strong) UILabel *kindLabel;
/** 狗狗种类 */
@property (strong, nonatomic)  UILabel *dogKindLabel;
/** 狗狗年龄*/
@property (strong, nonatomic)  UILabel *dogAgeLabel;
/** 狗狗体型*/
@property (strong, nonatomic)  UILabel *dogSizeLabel;
/** 狗狗颜色*/
@property (strong, nonatomic)  UILabel *dogColorLabel;
/** 狗狗价格*/
@property (strong, nonatomic)  UILabel *nowPriceLabel;
/** 狗狗老价格*/
@property (strong, nonatomic)  UILabel *oldPriceLabel;
/** 状态信息 */
@property (strong,nonatomic) UILabel *dogStateMessage;
/** 分割线 */
@property (strong,nonatomic) UIView *lineView;
/** 选中图片按钮 */
@property (strong,nonatomic) UIButton *selectButton;
/** 默认地址 */
@property (strong,nonatomic) UILabel *willShowLabel;
/** 编辑 */
@property (strong,nonatomic) UIButton *editBtn;
/** 删除 */
@property (strong,nonatomic) UIButton *deleteBtn;

@end

@implementation AddDogShowCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.dogStateTitle];
        
        [self.contentView addSubview:self.dogImageView];
        
        [self.contentView addSubview:self.dogNameLabel];
        
        [self.contentView addSubview:self.kindLabel];
        
        [self.contentView addSubview:self.dogKindLabel];
        
        [self.contentView addSubview:self.dogAgeLabel];
        
        [self.contentView addSubview:self.dogSizeLabel];
        
        [self.contentView addSubview:self.dogColorLabel];
        
        [self.contentView addSubview:self.nowPriceLabel];
        
        [self.contentView addSubview:self.oldPriceLabel];
        
        [self.contentView addSubview:self.dogStateMessage];
        
        [self.contentView addSubview:self.lineView];
        
        [self.contentView addSubview:self.selectButton];
        
        [self.contentView addSubview:self.willShowLabel];
        
        [self.contentView addSubview:self.editBtn];
        
        [self.contentView addSubview:self.deleteBtn];

    }
    return self;
}

#pragma mark
#pragma mark - 约束
- (void)layoutSubviews {
    [super layoutSubviews];
    
    __weak typeof(self) weakself = self;
    
    [_dogStateTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.left).offset(10);
        make.top.equalTo(weakself.top).offset(10);
    }];
    
    [_dogImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.dogStateTitle.bottom).offset(10);
        make.left.equalTo(weakself.left).offset(10);
        make.size.equalTo(CGSizeMake(78, 78));
    }];
    
    [_dogNameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.dogStateTitle.bottom).offset(15);
        make.left.equalTo(weakself.dogImageView.right).offset(10);
    }];
    
    [_kindLabel makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakself.dogNameLabel.bottom);
        make.left.equalTo(weakself.dogNameLabel.right).offset(10);
    }];
    
    [_dogKindLabel makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakself.dogNameLabel.bottom);
        make.left.equalTo(weakself.kindLabel.right).offset(10);
    }];

    [_dogAgeLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.dogNameLabel.bottom).offset(5);
        
        make.left.equalTo(weakself.dogImageView.right).offset(10);
        
    }];
    
    [_dogSizeLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(weakself.dogAgeLabel.centerY);
        
        make.left.equalTo(weakself.dogAgeLabel.right).offset(10);
        
    }];
    
    [_dogColorLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(weakself.dogAgeLabel.centerY);
        
        make.left.equalTo(weakself.dogSizeLabel.right).offset(10);
        
    }];
    
    
    
    [_nowPriceLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.dogAgeLabel.bottom);
        
        make.left.equalTo(weakself.dogImageView.right).offset(10);
        
    }];
    
    
    
    [_oldPriceLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.nowPriceLabel.bottom);
        
        make.left.equalTo(weakself.dogImageView.right).offset(10);
        
    }];
    
    [_dogStateMessage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakself.right).offset(-10);
        
        make.bottom.equalTo(weakself.dogImageView.bottom);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.dogImageView.bottom).offset(10);
       
        make.left.right.equalTo(weakself);
 
        make.height.equalTo(1);
    }];
    
    [_selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.left).offset(10);
        
        make.top.equalTo(weakself.lineView.bottom).offset(10);
        
    }];
    
    [_willShowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(weakself.selectButton.centerY);
        
        make.left.equalTo(weakself.selectButton.right).offset(10);
        
    }];
    
    [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(weakself.selectButton.centerY);
        
        make.right.equalTo(weakself.right).offset(-10);
        
        make.size.equalTo(CGSizeMake(48, 30));
        
    }];
    
    [_editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(weakself.selectButton.centerY);
        
        make.right.equalTo(weakself.deleteBtn.left).offset(-10);
        
        make.size.equalTo(CGSizeMake(48, 30));

    }];

}

- (void)setIsAllSelect:(BOOL)isAllSelect {
    _isAllSelect = isAllSelect;
    self.selectButton.selected = isAllSelect;
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
        state = @"新建商品";
    }else if ([model.status isEqualToString:@"2"]) {
        state = @"审核未通过";
    }else if ([model.status isEqualToString:@"3"]) {
        state = @"上线";
    }else if ([model.status isEqualToString:@"4"]) {
        state = @"下线";
    }else if ([model.status isEqualToString:@"5"]) {
        state = @"售完";
    }

    self.dogStateMessage.text = state;
    self.dogStateTitle.text = [NSString stringWithFormat:@"我的%@狗狗", state];
}
#pragma mark
#pragma mark - 懒加载
- (UILabel *)dogStateTitle {

    if (!_dogStateTitle) {
        
        _dogStateTitle = [[UILabel alloc] init];
        
        _dogStateTitle.textColor = [UIColor colorWithHexString:@"#333333"];
        
        _dogStateTitle.font = [UIFont systemFontOfSize:16];
        
        _dogStateTitle.text = @"我的代售狗狗";
    
    }
    return _dogStateTitle;
}

- (UIImageView *)dogImageView {
    
    if (!_dogImageView) {
        
        _dogImageView = [[UIImageView alloc] init];
        
        _dogImageView.image = [UIImage imageNamed:@"组-7"];
        
        _dogImageView.layer.cornerRadius = 10;
        
        _dogImageView.layer.masksToBounds = YES;
        
    }
    
    return _dogImageView;
    
}

- (UILabel *)dogNameLabel {
    
    if (!_dogNameLabel) {
        
        _dogNameLabel = [[UILabel alloc] init];
        
        _dogNameLabel.text = @"小黑";
        
        _dogNameLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        
        _dogNameLabel.font = [UIFont systemFontOfSize:16];
        
        
        
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

- (UILabel *)dogStateMessage {
    
    if (!_dogStateMessage) {
       
        _dogStateMessage = [[UILabel alloc] init];
        
        _dogStateMessage.textColor = [UIColor colorWithHexString:@"#666666"];
        
        _dogStateMessage.font = [UIFont systemFontOfSize:14];
        
        _dogStateMessage.text = @"代售";
    
    }
    return _dogStateMessage;
}

- (UIView *)lineView {
    
    if (!_lineView) {
        
        _lineView = [[UIView alloc] init];
        
        _lineView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    
    }
    return _lineView;
}

- (UIButton *)selectButton {
    
    if (!_selectButton) {
       
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_selectButton setImage:[UIImage imageNamed:@"椭圆-1"] forState:UIControlStateNormal];
        
        [_selectButton setImage:[UIImage imageNamed:@"圆角-对勾"] forState:UIControlStateSelected];
        
        [_selectButton addTarget:self action:@selector(cilckDuihaoImageBtn:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _selectButton;
}

- (UILabel *)willShowLabel {
    
    if (!_willShowLabel) {
       
        _willShowLabel = [[UILabel alloc] init];
        
        _willShowLabel.text = @"即将展播";
        
        _willShowLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        
        _willShowLabel.font = [UIFont systemFontOfSize:12];
    
    }
    return _willShowLabel;
}

- (UIButton *)editBtn {
    
    if (!_editBtn) {
        
        _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_editBtn setImage:[UIImage imageNamed:@"编辑"] forState:UIControlStateNormal];
        
        [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        
        _editBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
        
        //button标题的偏移量，这个偏移量是相对于图片的
        _editBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        
        [_editBtn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        
        _editBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [_editBtn addTarget:self action:@selector(clickEditBuotton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editBtn;
}

- (UIButton *)deleteBtn {
    
    if (!_deleteBtn) {
        
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_deleteBtn setImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
        [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        
        _deleteBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
        //button标题的偏移量，这个偏移量是相对于图片的
        _deleteBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        
        [_deleteBtn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        _deleteBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [_deleteBtn addTarget:self action:@selector(cilckDeleteButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}
#pragma mark
#pragma mark - Action
// 点击编辑按钮
- (void)clickEditBuotton {
    
    if (_editButtonBlock) {
        _editButtonBlock();
    }
    
}

- (void)cilckDeleteButton {
    if (_deleteButtonBlock) {
        _deleteButtonBlock();
    }
    
}

- (void)cilckDuihaoImageBtn:(UIButton *)button {
    
    if (_selectBtnBlock) {
        _selectBtnBlock(button);
    }
}

@end
