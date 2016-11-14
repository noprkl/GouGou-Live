//
//  MyPagePictureView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/14.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "MyPagePictureView.h"
#import "ShareBtn.h"

@interface MyPagePictureView ()

@property(nonatomic, strong) UILabel *AlumLabel; /**< 相册 */

@property(nonatomic, strong) ShareBtn *factorySceneBtn; /**< 厂房外景 */

@property(nonatomic, strong) ShareBtn *DogPictureBtn; /**< 狗狗实景 */

@property(nonatomic, strong) UIButton *manageBtn; /**< 管理相册 */

@end
@implementation MyPagePictureView
- (instancetype)initWithFrame:(CGRect)frame withpictures:(NSArray *)pictures {
    if (self = [super init]) {
        
        [self addSubview:self.AlumLabel];
        [self addSubview:self.manageBtn];
    
        [self setBtn:self.factorySceneBtn title:@"厂房外景" normalImage:[UIImage imageNamed:pictures[0]]];
        [self setBtn:self.DogPictureBtn title:@"狗狗实景" normalImage:[UIImage imageNamed:pictures[1]]];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.AlumLabel];
        [self addSubview:self.manageBtn];
        [self addSubview:self.factorySceneBtn];
        [self addSubview:self.DogPictureBtn];
    }
    return self;
}

// 设置图片的信息 相册名字和相册图片
- (void)setPictures:(NSArray *)pictures {
    _pictures = pictures;
    self.factorySceneBtn.hidden = NO;
    self.DogPictureBtn.hidden = NO;
    
    if (pictures.count == 0) {
        self.factorySceneBtn.hidden = YES;
        self.DogPictureBtn.hidden = YES;
    }
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    [self.AlumLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).offset(10);
        make.top.equalTo(self.top).offset(10);
    }];
    
    [self.manageBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.AlumLabel.centerY);
        make.right.equalTo(self.right).offset(-10);
    }];
    
    [self.factorySceneBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.AlumLabel.bottom).offset(10);
        make.left.equalTo(self.left).offset(10);
        make.size.equalTo(CGSizeMake(172, 172));
    }];
    
    [self.DogPictureBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.AlumLabel.bottom).offset(10);
        make.right.equalTo(self.right).offset(-10);
        make.size.equalTo(CGSizeMake(172, 172));
    }];
}

#pragma mark
#pragma mark - Action
- (void)clickFactoryBtnAction:(UIButton *)btn {
    if (_factoryBlock) {
        _factoryBlock();
    }
}
- (void)clickDogViewBtnAction:(UIButton *)btn {
    if (_dogViewBlock) {
        _dogViewBlock();
    }
}
- (void)clickManageBtnAction:(UIButton *)btn {
    if (_manageBlock) {
        _manageBlock();
    }
}
#pragma mark
#pragma mark - 懒加载
- (ShareBtn *)factorySceneBtn {
    if (!_factorySceneBtn) {
        _factorySceneBtn = [ShareBtn buttonWithType:(UIButtonTypeCustom)];
        NSDictionary *normalAttributeDict = @{
                                              NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#333333"],
                                              NSFontAttributeName:[UIFont systemFontOfSize:12]
                                              };
        NSAttributedString *normalAttribute = [[NSAttributedString alloc] initWithString:@"厂房外景" attributes:normalAttributeDict];
        
        [_factorySceneBtn setAttributedTitle:normalAttribute forState:(UIControlStateNormal)];
        
        [_factorySceneBtn setImage:[UIImage imageNamed:@"品种02"] forState:(UIControlStateNormal)];

        [_factorySceneBtn addTarget:self action:@selector(clickFactoryBtnAction:) forControlEvents:(UIControlEventTouchDown)];
    }
    return _factorySceneBtn;
}
- (ShareBtn *)DogPictureBtn {
    if (!_DogPictureBtn) {
        _DogPictureBtn = [ShareBtn buttonWithType:(UIButtonTypeCustom)];
        NSDictionary *normalAttributeDict = @{
                                              NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#333333"],
                                              NSFontAttributeName:[UIFont systemFontOfSize:12]
                                              };
        NSAttributedString *normalAttribute = [[NSAttributedString alloc] initWithString:@"狗狗实景" attributes:normalAttributeDict];
        
        [_DogPictureBtn setAttributedTitle:normalAttribute forState:(UIControlStateNormal)];
        
        [_DogPictureBtn setImage:[UIImage imageNamed:@"品种"] forState:(UIControlStateNormal)];

        [_DogPictureBtn addTarget:self action:@selector(clickDogViewBtnAction:) forControlEvents:(UIControlEventTouchDown)];
    }
    return _DogPictureBtn;
}
- (void)setBtn:(UIButton *)button title:(NSString *)title normalImage:(UIImage *)normalImage {
    
    // 正常
    NSDictionary *normalAttributeDict = @{
                                          NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#333333"],
                                          NSFontAttributeName:[UIFont systemFontOfSize:12]
                                          };
    NSAttributedString *normalAttribute = [[NSAttributedString alloc] initWithString:title attributes:normalAttributeDict];
    
    [button setAttributedTitle:normalAttribute forState:(UIControlStateNormal)];
    //    button.imageView.frame = button.bounds;
    //    button.hidden = NO;
    [normalImage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    [button setImage:normalImage forState:(UIControlStateNormal)];
    
    
    [self addSubview:button];
}

- (UILabel *)AlumLabel {
    if (!_AlumLabel) {
        _AlumLabel = [[UILabel alloc] init];
        _AlumLabel.text = @"相册";
        _AlumLabel.font = [UIFont systemFontOfSize:16];
        _AlumLabel.textColor = [UIColor colorWithHexString:@"#000000"];
    }
    return _AlumLabel;
}
- (UIButton *)manageBtn {
    if (!_manageBtn) {
        _manageBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_manageBtn setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:(UIControlStateNormal)];
        _manageBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_manageBtn setTitle:@"管理" forState:(UIControlStateNormal)];

        [_manageBtn addTarget:self action:@selector(clickManageBtnAction:) forControlEvents:(UIControlEventTouchDown)];
    }
    return _manageBtn;
}
@end
