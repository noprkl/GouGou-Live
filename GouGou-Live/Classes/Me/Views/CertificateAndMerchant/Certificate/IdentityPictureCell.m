//
//  IdentityPictureCell.m
//  GouGou-Live
//
//  Created by ma c on 16/11/8.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "IdentityPictureCell.h"

@interface IdentityPictureCell ()
/** 提示信息 */
@property (strong,nonatomic) UILabel *promptLabel;
/** 示例view */
@property (strong,nonatomic) UIView *instanceView;
/** 正面实例 */
@property (strong,nonatomic) UIImageView *instanceImage;
/** 图片提示 */
@property (strong,nonatomic) UILabel *instanceLabel;
/** 图片View */
@property (strong,nonatomic) UIView *realPictureView;
/** 身份证 */
@property (strong,nonatomic) UIImageView *identityImage;
/** 提示 */
@property (strong,nonatomic) UILabel *identityLabel;

@end

@implementation IdentityPictureCell

- (void)identityWithPromptlabel:(NSString *)promptText instanceImage:(UIImage *)instanceImage instanceLabe:(NSString *)instabceLabeltext identityImage:(UIImage *)identityImage identityLabel:(NSString *)idebtityLabelText {

    self.promptLabel.text = promptText;
    self.instanceImage.image = instanceImage;
    self.instanceLabel.text = instabceLabeltext;
    self.identityImage.image = identityImage;
    self.identityLabel.text = idebtityLabelText;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.promptLabel];
        [self.contentView addSubview:self.instanceView];

        [self.instanceView addSubview:self.instanceImage];
        [self.instanceView addSubview:self.instanceLabel];

        [self.contentView addSubview:self.realPictureView];

        [self.realPictureView addSubview:self.identityImage];
        [self.realPictureView addSubview:self.identityLabel];
        
    }
    return self;
}
#pragma mark
#pragma mark - 约束
- (void)layoutSubviews {

    [super layoutSubviews];
    __weak typeof(self) weakself = self;

    [_promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.left).offset(10);
        make.top.equalTo(weakself.top).offset(15);
    
        
    }];
    
    [_instanceView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.top).offset(44);
        make.left.equalTo(weakself.left).offset(40);
        make.right.equalTo(weakself.right).offset(-40);
        make.height.equalTo(168);
        
    }];
    
    [_instanceImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.instanceView.top).offset(20);
        make.centerX.equalTo(weakself.instanceView.centerX);
        make.size.equalTo(CGSizeMake(167, 105));
    }];

    [_instanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.instanceImage.bottom).offset(10);
        make.centerX.equalTo(weakself.instanceImage.centerX);
        
    }];
   
    [_realPictureView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.instanceView.bottom).offset(25);
        make.left.equalTo(weakself.left).offset(40);
        make.right.equalTo(weakself.right).offset(-40);
        make.height.equalTo(168);
        
    }];

    [_identityImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.realPictureView.top).offset(20);
        make.centerX.equalTo(weakself.realPictureView.centerX);
        make.size.equalTo(CGSizeMake(167, 105));
    }];

    [_identityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.identityImage.bottom).offset(10);
        make.centerX.equalTo(weakself.identityImage.centerX);
        
    }];
    
}

#pragma mark
#pragma mark - 懒加载
- (UILabel *)promptLabel {

    if (!_promptLabel) {
        _promptLabel = [[UILabel alloc] init];
        _promptLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _promptLabel.font = [UIFont systemFontOfSize:14];
        
    }
    return _promptLabel;
}

- (UIView *)instanceView {

    if (!_instanceView) {
        _instanceView = [[UIView alloc] init];
        _instanceView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    }
    return _instanceView;
}

- (UIImageView *)instanceImage {

    if (!_instanceImage) {
        _instanceImage = [[UIImageView alloc] init];
    }
    return _instanceImage;
}

- (UILabel *)instanceLabel {

    if (!_instanceLabel) {
        _instanceLabel = [[UILabel alloc] init];
        _instanceLabel.font = [UIFont systemFontOfSize:16];
        
        _instanceLabel.textColor = [UIColor colorWithHexString:@"#cccccc"];
    }
    return _instanceLabel;
}

- (UIView *)realPictureView {
    
    if (!_realPictureView) {
        _realPictureView = [[UIView alloc] init];
        _realPictureView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    }
    return _realPictureView;
}

- (UIImageView *)identityImage {
    
    if (!_identityImage) {
        _identityImage = [[UIImageView alloc] init];

        _identityImage.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTapped)];
        
        [_identityImage addGestureRecognizer:singleTap];
    }
    return _identityImage;
}

- (UILabel *)identityLabel {
    
    if (!_identityLabel) {
        _identityLabel = [[UILabel alloc] init];
        _identityLabel.font = [UIFont systemFontOfSize:16];
        _identityLabel.textColor = [UIColor colorWithHexString:@"#cccccc"];
    }
    return _identityLabel;
}

- (void)cilckToChoosePicture {


}

- (void)photoTapped {

    if (_addIdentityBlock) {
        _addIdentityBlock(self.identityImage);
    }

}

- (void)awakeFromNib {
    [super awakeFromNib];
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
