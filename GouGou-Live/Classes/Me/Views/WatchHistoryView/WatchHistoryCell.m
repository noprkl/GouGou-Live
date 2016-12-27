//
//  WatchHistoryCell.m
//  GouGou-Live
//
//  Created by ma c on 16/11/7.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "WatchHistoryCell.h"

@interface WatchHistoryCell ()

/** 头像 */
@property (strong,nonatomic) UIImageView *photoImage;
/** 商家名称 */
@property (strong,nonatomic) UILabel *businessName;
/** 认证商家 */
@property (strong,nonatomic) UILabel *certifiedBusiness;
/** 狗狗截图 */
@property (strong,nonatomic) UIImageView *dogImage;
/** 结束文字 */
@property (strong,nonatomic) UILabel *overLabel;
/** 狗狗信息蒙版 */
@property (strong,nonatomic) UIView *hudView;
/** 品种 */
@property (strong,nonatomic) UILabel *varietyInfo;
/** 销售情况 */
@property (strong,nonatomic) UILabel *sellInfo;
/** 日期时间 */
@property (strong,nonatomic) UILabel *dataLabel;
/** 删除按钮 */
@property (strong,nonatomic) UIButton *deleteButton;
/** 间隔 */
@property (strong,nonatomic) UIView *spaceView;
/** 随后选中状态 */
@property (strong,nonatomic) UIButton *lastChooseBtn;

@end

@implementation WatchHistoryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
        [self.contentView addSubview:self.photoImage];
        [self.contentView addSubview:self.businessName];
        [self.contentView addSubview:self.certifiedBusiness];
        [self.contentView addSubview:self.dogImage];
        [self.contentView addSubview:self.overLabel];
        [self.contentView addSubview:self.hudView];
        [self.hudView addSubview:self.varietyInfo];
        [self.hudView addSubview:self.sellInfo];
        [self.contentView addSubview:self.dataLabel];
        [self.contentView addSubview:self.deleteButton];
        [self.contentView addSubview:self.spaceView];
        
    }
    return self;
}
- (void)setModel:(PlayBackModel *)model {
    _model = model;
    if (model.userImgUrl != NULL) {
        NSString *imgUrl = [IMAGE_HOST stringByAppendingString:model.userImgUrl];
        [self.photoImage sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"主播头像"]];
    }
    if (model.snapshot != NULL) {
        [self.dogImage sd_setImageWithURL:[NSURL URLWithString:model.snapshot] placeholderImage:[UIImage imageNamed:@"直播图"]];
    }
    self.businessName.text = model.merchantName;
    self.varietyInfo.text = model.name;
    
    self.sellInfo.text = [NSString stringWithFormat:@"展%ld售%ld", model.pNum, (model.pNum - model.num)];
    self.dataLabel.text = [NSString stringFromDateString:model.createTime];
}
#pragma mark
#pragma mark - 约束
- (void)layoutSubviews {

    [super layoutSubviews];
    
    __weak typeof(self) weakself = self;

    [_photoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.left).offset(10);
        make.top.equalTo(weakself.top).offset(7);
        make.size.equalTo(CGSizeMake(30, 30));
    }];
    
    [_businessName mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.photoImage.right).offset(10);
        make.centerY.equalTo(weakself.photoImage.centerY);
        
    }];

    [_certifiedBusiness mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.businessName.right).offset(10);
        make.centerY.equalTo(weakself.photoImage.centerY);
        make.size.equalTo(CGSizeMake(70, 22));
        
    }];

    [_dogImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.top).offset(44);
        make.left.right.equalTo(weakself);
        make.height.equalTo(175);
    }];

    [_overLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.equalTo(weakself.top).offset(54);
        make.right.equalTo(weakself.right).offset(-10);
        make.size.equalTo(CGSizeMake(70, 20));
        
    }];

    [_hudView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(weakself);
        make.top.equalTo(weakself.top).offset(186);
        make.height.equalTo(33);
        
    }];

    [_varietyInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.hudView.left).offset(10);
        make.centerY.equalTo(weakself.hudView.centerY);
        
    }];

    [_sellInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakself.hudView.right).offset(-10);
        make.centerY.equalTo(weakself.hudView.centerY);
        
    }];

    [_dataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.hudView.bottom).offset(15);
        make.left.equalTo(weakself.left).offset(10);
        
    }];
    
    [_deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakself.right).offset(-10);
        make.centerY.equalTo(weakself.dataLabel.centerY);
        make.size.equalTo(CGSizeMake(75, 33));
        
    }];

    [_spaceView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(weakself);
        make.top.equalTo(weakself.deleteButton.bottom).offset(5);
        make.height.equalTo(10);
    }];
    
}

#pragma mark
#pragma mark - 懒加载
- (UIImageView *)photoImage {

    if (!_photoImage) {
        _photoImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"主播头像"]];
        _photoImage.layer.cornerRadius = 15;
        _photoImage.layer.masksToBounds = YES;
    }
    return _photoImage;
}

- (UILabel *)businessName {

    if (!_businessName) {
        _businessName = [[UILabel alloc] init];
        _businessName.text = @"陈家狗狗培育中心";
        _businessName.textColor = [UIColor colorWithHexString:@"#000000"];
        _businessName.font = [UIFont systemFontOfSize:14];
    }
    return _businessName;
}

- (UILabel *)certifiedBusiness {

    if (!_certifiedBusiness) {
        _certifiedBusiness = [[UILabel alloc] init];
        _certifiedBusiness.textColor = [UIColor colorWithHexString:@"#ffffff"];
        _certifiedBusiness.text = @"认证商家";
        _certifiedBusiness.layer.cornerRadius = 5;
        _certifiedBusiness.layer.masksToBounds = YES;
        _certifiedBusiness.textAlignment = NSTextAlignmentCenter;
        _certifiedBusiness.backgroundColor = [UIColor orangeColor];
        _certifiedBusiness.font = [UIFont systemFontOfSize:14];
    }
    return _certifiedBusiness;
}

- (UIImageView *)dogImage {

    if (!_dogImage) {
        _dogImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"直播图"]];
        
    }
    return _dogImage;
}

- (UIView *)hudView {

    if (!_hudView) {
        _hudView = [[UIView alloc] init];
        _hudView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        
    }
    return _hudView;
}

-(UILabel *)overLabel {

    if (!_overLabel) {
        _overLabel = [[UILabel alloc] init];
        _overLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        _overLabel.layer.cornerRadius = 5;
        _overLabel.layer.masksToBounds = YES;
        _overLabel.text = @"已结束";
        _overLabel.textAlignment = NSTextAlignmentCenter;
        _overLabel.textColor  = [UIColor colorWithHexString:@"#ffffff"];
        _overLabel.font = [UIFont systemFontOfSize:12];
    }
    return _overLabel;
}
- (UILabel *)varietyInfo {

    if (!_varietyInfo) {
        _varietyInfo = [[UILabel alloc] init];
        _varietyInfo.text = @"一窝纯种拉布拉多出售";
        _varietyInfo.textColor = [UIColor colorWithHexString:@"#ffffff"];
        _varietyInfo.font = [UIFont systemFontOfSize:12];
    }
    return _varietyInfo;
}

- (UILabel *)sellInfo {

    if (!_sellInfo) {
        _sellInfo = [[UILabel alloc] init];
        _sellInfo.textColor = [UIColor colorWithHexString:@"#ffffff"];
        _sellInfo.text = @"展播8出售6";
        _sellInfo.font = [UIFont systemFontOfSize:12];
    }
    return _sellInfo;
}

- (UILabel *)dataLabel {

    if (!_dataLabel) {
        _dataLabel = [[UILabel alloc] init];
        _dataLabel.text = @"2016-11-7 10:00";
        _dataLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _dataLabel.font = [UIFont systemFontOfSize:12];
    }
    return _dataLabel;
}

- (UIButton *)deleteButton {

    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteButton.layer.cornerRadius = 5;
        _deleteButton.layer.masksToBounds = YES;
        _deleteButton.layer.borderWidth = 1;
        _deleteButton.layer.borderColor = [UIColor colorWithHexString:@"#99cc33"].CGColor;
        _deleteButton.selected = NO;
        [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteButton setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
        [_deleteButton setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateSelected];
        _deleteButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_deleteButton addTarget:self action:@selector(deleteButton:) forControlEvents:UIControlEventTouchUpInside];
        [_deleteButton addTarget:self action:@selector(changeBtnColor:) forControlEvents:UIControlEventTouchDown];
    }
    return _deleteButton;
}

- (UIView *)spaceView {

    if (!_spaceView) {
        _spaceView = [[UIView alloc] init];
        _spaceView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _spaceView;
}

- (void)deleteButton:(UIButton *)btn {
    
    [btn setBackgroundColor:[UIColor colorWithHexString:@"#ffffff"]];
    [btn setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
    if (_deleBlock) {
        _deleBlock(btn);
    }
}

- (void)changeBtnColor:(UIButton *)btn {
    
    [btn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor colorWithHexString:@"#99cc33"]];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
