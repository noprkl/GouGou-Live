//
//  PicturesView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/2.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "PicturesView.h"
#import "ShareBtn.h"

@interface PicturesView ()
@property(nonatomic, strong) UILabel *AlumLabel; /**< 相册 */

@property(nonatomic, strong) ShareBtn *factorySceneBtn; /**< 厂房外景 */

@property(nonatomic, strong) ShareBtn *DogPictureBtn; /**< 狗狗实景 */

@end
@implementation PicturesView
- (instancetype)initWithFrame:(CGRect)frame withpictures:(NSArray *)pictures {
    if (self = [super init]) {
        
        [self addSubview:self.AlumLabel];
       
        [self setBtn:self.factorySceneBtn title:@"厂房外景" normalImage:[UIImage imageNamed:pictures[0]]];
        [self setBtn:self.DogPictureBtn title:@"狗狗实景" normalImage:[UIImage imageNamed:pictures[1]]];

    }
    return self;
}
- (void)layoutSubviews {
    
    [super layoutSubviews];
    [self.AlumLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).offset(10);
        make.top.equalTo(self.top).offset(10);
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
#pragma mark
#pragma mark - 懒加载
- (ShareBtn *)factorySceneBtn {
    if (!_factorySceneBtn) {
        _factorySceneBtn = [ShareBtn buttonWithType:(UIButtonTypeCustom)];
        [_factorySceneBtn addTarget:self action:@selector(clickFactoryBtnAction:) forControlEvents:(UIControlEventTouchDown)];
    }
    return _factorySceneBtn;
}
- (ShareBtn *)DogPictureBtn {
    if (!_DogPictureBtn) {
        _DogPictureBtn = [ShareBtn buttonWithType:(UIButtonTypeCustom)];
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
@end
