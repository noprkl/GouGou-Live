//
//  AddrsssTableViewCell.m
//  GouGou-Live
//
//  Created by ma c on 16/11/3.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "AddrsssTableViewCell.h"
#import "DeletePrommtView.h"
#import "MyShopAdressModel.h"

@interface AddrsssTableViewCell ()
/** 间隔view */
@property (strong,nonatomic) UIView *spaceView;
/** 联系人 */
@property (strong,nonatomic) UILabel *relationLabel;
/** 用户名 */
@property (strong,nonatomic) UILabel *userName;
/** 电话号码 */
@property (strong,nonatomic) UILabel *phoneTextfiled;
/** 地址 */
@property (strong,nonatomic) UILabel *addressLabel;
/** 详细地址 */
@property (strong,nonatomic) UILabel *detailAddress;
/** 分割线 */
@property (strong,nonatomic) UIView *lineView;
/** 对号图片 */
@property (strong,nonatomic) UIButton *duihaoImageBtn;
/** 默认地址 */
@property (strong,nonatomic) UILabel *acquiesceAddressLabel;
/** 编辑 */
@property (strong,nonatomic) UIButton *editBtn;
/** 删除 */
@property (strong,nonatomic) UIButton *deleteBtn;

@end

@implementation AddrsssTableViewCell
#pragma mark
#pragma mark - 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.spaceView];
        [self.contentView addSubview:self.relationLabel];
        [self.contentView addSubview:self.userName];
        [self.contentView addSubview:self.phoneTextfiled];
        [self.contentView addSubview:self.addressLabel];
        [self.contentView addSubview:self.detailAddress];
        [self.contentView addSubview:self.lineView];
        [self.contentView addSubview:self.duihaoImageBtn];
        [self.contentView addSubview:self.acquiesceAddressLabel];
        [self.contentView addSubview:self.editBtn];
        [self.contentView addSubview:self.deleteBtn];
       
     }
    return self;
}
- (void)setAdressModel:(MyShopAdressModel *)adressModel {
    _adressModel = adressModel;
    self.userName.text = adressModel.userName;
    self.phoneTextfiled.text = adressModel.userTel;
    NSString *adress = [NSString stringWithFormat:@"%@,%@,%@,%@", adressModel.userProvince, adressModel.userCity, adressModel.userDistrict, adressModel.userAddress];
    self.detailAddress.text = adress;
    if (adressModel.isDefault == 1) {
        self.duihaoImageBtn.selected = YES;
    }else{
        self.duihaoImageBtn.selected = NO;
    }
    
}
#pragma mark
#pragma mark - 约束
- (void)layoutSubviews {

    [super layoutSubviews];
    
    __weak typeof(self) weakself = self;
    
    [_spaceView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.right.equalTo(weakself);
        make.height.equalTo(10);
        
    }];
    
    [_relationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.spaceView.bottom).offset(10);
        make.left.equalTo(weakself.left).offset(10);
        make.height.equalTo(15);
        
    }];
    
    [_userName mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.relationLabel.right).offset(10);
        make.centerY.equalTo(weakself.relationLabel.centerY);
        make.size.equalTo(CGSizeMake(200, 15));
        
    }];

    [_phoneTextfiled mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.userName.right).offset(5);
        make.centerY.equalTo(weakself.relationLabel.centerY);
        make.height.equalTo(15);
        
    }];

    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.relationLabel.bottom).offset(10);
        make.left.equalTo(weakself.left).offset(10);
        make.height.equalTo(15);
        
    }];

    [_detailAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(weakself.addressLabel.centerY);
        make.left.equalTo(weakself.addressLabel.right).offset(10);
        make.height.equalTo(15);
        
    }];

    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.detailAddress.bottom).offset(10);
        make.left.equalTo(weakself.left).offset(10);
        make.right.equalTo(weakself.right).offset(-10);
        make.height.equalTo(1);
        
    }];
    
    [_duihaoImageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.left).offset(10);
        make.bottom.equalTo(self.bottom).offset(-10);
        
    }];
    
    [_acquiesceAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(weakself.duihaoImageBtn.centerY);
        make.left.equalTo(weakself.duihaoImageBtn.right).offset(10);
        
    }];
    
    [_editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(weakself.duihaoImageBtn.centerY);
        make.left.equalTo(weakself.acquiesceAddressLabel.right).offset(150);
        
    }];
    
    [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(weakself.duihaoImageBtn.centerY);
        make.left.equalTo(weakself.editBtn.right).offset(10);
        
    }];

}
#pragma mark
#pragma mark - 懒加载
-  (UIView *)spaceView {

    if (!_spaceView) {
        _spaceView = [[UIView alloc] init];
        _spaceView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _spaceView;
}

- (UILabel *)relationLabel {

    if (!_relationLabel) {
        _relationLabel = [[UILabel alloc] init];
        _relationLabel.text = @"联系人:";
        _relationLabel.font = [UIFont systemFontOfSize:16];
        _relationLabel.textColor = [UIColor colorWithHexString:@"#000000"];
    }
    return _relationLabel;
}

- (UILabel *)userName {

    if (!_userName) {
        _userName = [[UILabel alloc] init];
        _userName.text = @"用户名";
        _userName.textColor  = [UIColor colorWithHexString:@"#333333"];
        _userName.font = [UIFont systemFontOfSize:14];
    }
    return _userName;
}

- (UILabel *)phoneTextfiled {
    
    if (!_phoneTextfiled) {
        _phoneTextfiled = [[UILabel alloc] init];
        _phoneTextfiled.text = @"18329836547";
        _phoneTextfiled.textColor  = [UIColor colorWithHexString:@"#666666"];
        _phoneTextfiled.font = [UIFont systemFontOfSize:12];
    }
    return _phoneTextfiled;
}

- (UILabel *)addressLabel {
    
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.text = @"地址:";
        _addressLabel.font = [UIFont systemFontOfSize:14];
        _addressLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    }
    return _addressLabel;
}

- (UILabel *)detailAddress {
    
    if (!_detailAddress) {
        _detailAddress = [[UILabel alloc] init];
        _detailAddress.text = @"北京，北京市，朝阳区，将台将府家园";
        _detailAddress.textColor  = [UIColor colorWithHexString:@"#666666"];
        _detailAddress.font = [UIFont systemFontOfSize:14];
    }
    return _detailAddress;
}

- (UIView *)lineView {
    
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _lineView;
}

- (UIButton *)duihaoImageBtn {

    if (!_duihaoImageBtn) {
        _duihaoImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_duihaoImageBtn setImage:[UIImage imageNamed:@"椭圆-1"] forState:UIControlStateNormal];
        [_duihaoImageBtn setImage:[UIImage imageNamed:@"圆角-对勾"] forState:UIControlStateSelected];
        
        [_duihaoImageBtn addTarget:self action:@selector(cilckDuihaoImageBtn:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _duihaoImageBtn;
}

- (UILabel *)acquiesceAddressLabel {

    if (!_acquiesceAddressLabel) {
        _acquiesceAddressLabel = [[UILabel alloc] init];
        _acquiesceAddressLabel.text = @"默认收货地址";
        _acquiesceAddressLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _acquiesceAddressLabel.font = [UIFont systemFontOfSize:12];
    }
    return _acquiesceAddressLabel;
}

- (UIButton *)editBtn {

    if (!_editBtn) {
        
        _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_editBtn setImage:[UIImage imageNamed:@"编辑"] forState:UIControlStateNormal];
        [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        
        _editBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 30);
        //button标题的偏移量，这个偏移量是相对于图片的
        _editBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        
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
        
        _deleteBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 30);
        //button标题的偏移量，这个偏移量是相对于图片的
        _deleteBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        
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
    
    if (_editBtnBlock) {
        _editBtnBlock();
    }
    
}

- (void)cilckDeleteButton {
    if (_deleteBlock) {
        _deleteBlock(self.deleteBtn);
    }
    
}

- (void)cilckDuihaoImageBtn:(UIButton *)button {

//    button.selected = !button.selected;
    if (_acquiesceBlock) {
        _acquiesceBlock(button);
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
