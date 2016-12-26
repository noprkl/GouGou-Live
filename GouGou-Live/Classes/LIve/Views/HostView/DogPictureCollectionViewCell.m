//
//  DogPictureCollectionViewCell.m
//  GouGou-Live
//
//  Created by ma c on 16/10/27.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "DogPictureCollectionViewCell.h"

#import "HostLiveModel.h"

@interface DogPictureCollectionViewCell ()

/** 狗狗图片 */
@property (strong,nonatomic) UIImageView *liveDogPicture;
/** 标题 */
@property (strong,nonatomic) UILabel *titlelable;
/** 关注人图片 */
@property (strong,nonatomic) UIImageView *personImage;
/** 人数 */
@property (strong,nonatomic) UILabel *personNumLable;
/** HUD */
@property (strong,nonatomic) UIView *hudView;
/** 狗狗简介 */
@property (strong,nonatomic) UILabel *degistLable;
/** 销量 */
@property (strong,nonatomic) UILabel *salesvolumeLable;

@end

@implementation DogPictureCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.liveDogPicture];
        [self addSubview:self.titlelable];
        [self addSubview:self.personImage];
        [self addSubview:self.hudView];
        [self.hudView addSubview:self.degistLable];
        [self.hudView addSubview:self.salesvolumeLable];
        [self addSubview:self.personNumLable];
    }
    return self;
}
- (void)setModel:(HostLiveModel *)model {
    
    _model = model;
    if (model.snapshot != NULL) {
        [self.liveDogPicture sd_setImageWithURL:[NSURL URLWithString:model.snapshot] placeholderImage:[UIImage imageNamed:@"品种"]];
    }
    self.titlelable.text = model.userNickName;
    self.degistLable.text = model.name;
    self.salesvolumeLable.text = [NSString stringWithFormat:@"在售%ld/%ld", model.num, model.pNum];
    self.personNumLable.text = model.viewNum;
}
#pragma mark
#pragma mark - 约束
- (void)layoutSubviews {
    [super layoutSubviews];
    
    __weak typeof(self) weakself = self;
    [_liveDogPicture mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.equalTo(weakself).offset(10);
        make.right.equalTo(weakself.right).offset(-10);
        make.height.equalTo(92);
    }];
    
    [_hudView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakself.liveDogPicture);
        make.bottom.equalTo(weakself.liveDogPicture);
        make.height.equalTo(20);
    }];
    
    [_degistLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.hudView.left).offset(5);
        make.centerY.equalTo(weakself.hudView.centerY);
        make.height.equalTo(weakself.hudView.height);
    }];
    
    [_salesvolumeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(weakself.hudView.height);
        make.right.equalTo(weakself.hudView.right).offset(- 5);
        make.centerY.equalTo(weakself.degistLable.centerY);
        
    }];
    
    [_titlelable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.liveDogPicture.bottom).offset(5);
        make.left.equalTo(weakself.liveDogPicture.left);
    }];
    
    [_personNumLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(weakself.titlelable.centerY);
        make.right.equalTo(weakself.liveDogPicture.right);
        
    }];
    
    [_personImage mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(weakself.personNumLable.centerY);
        make.right.equalTo(weakself.personNumLable.left).offset(-5);
        
    }];
    
   
}

#pragma mark
#pragma mark - 懒加载
- (UIImageView *)liveDogPicture {
    
    if (!_liveDogPicture) {
        _liveDogPicture = [[UIImageView alloc] init];
        _liveDogPicture.image = [UIImage imageNamed:@"品种02"];

    }
    return _liveDogPicture;
}

- (UILabel *)titlelable {

    if (!_titlelable) {
        _titlelable = [[UILabel alloc] init];
        _titlelable.textColor = [UIColor colorWithHexString:@"#000000"];
        _titlelable.font = [UIFont systemFontOfSize:14];
        _titlelable.text = @"陈家狗狗培育中心";

        
    }
    return _titlelable;
}

- (UIImageView *)personImage {

    if (!_personImage) {
        _personImage = [[UIImageView alloc] init];
        _personImage.image = [UIImage imageNamed:@"小联系人（辅助）"];
        
    }
    return _personImage;
}
- (UILabel *)personNumLable {

    if (!_personNumLable) {
        _personNumLable = [[UILabel alloc] init];
        _personNumLable.textColor = [UIColor colorWithHexString:@"#999999"];
        _personNumLable.text = @"1234";
        _personNumLable.font = [UIFont systemFontOfSize:12];

    }
    return _personNumLable;
}

- (UIView *)hudView {

    if (!_hudView) {
        _hudView = [[UIView alloc] init];
        _hudView.backgroundColor = [UIColor blackColor];
        _hudView.alpha = 0.3;
    }
    return _hudView;
}

- (UILabel *)degistLable {

    if (!_degistLable) {
        _degistLable = [[UILabel alloc] init];
        _degistLable.text = @"纯品种,刚下6只";
        _degistLable.textColor = [UIColor colorWithHexString:@"#ffffff"];
        _degistLable.font = [UIFont systemFontOfSize:12];
//        _degistLable.backgroundColor = [UIColor redColor];
    }
    return _degistLable;
}

- (UILabel *)salesvolumeLable {

    if (!_salesvolumeLable) {
        _salesvolumeLable = [[UILabel alloc] init];
        _salesvolumeLable.textColor = [UIColor colorWithHexString:@"#ffffff"];
        _salesvolumeLable.text = @"在售3/5";
        _salesvolumeLable.font = [UIFont systemFontOfSize:12];
//        _salesvolumeLable.backgroundColor = [UIColor redColor];

    }
    return _salesvolumeLable;
}

@end
