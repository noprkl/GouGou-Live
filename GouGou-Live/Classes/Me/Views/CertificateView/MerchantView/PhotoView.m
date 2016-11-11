//
//  PhotoView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/9.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "PhotoView.h"


@interface PhotoView  ()
/** 提示文字 */
@property (strong,nonatomic) UILabel *textlable;
/** 添加按钮 */
@property (strong,nonatomic) UIButton *addImageBtn;
/** 横线 */
@property (strong,nonatomic) UIView *lineView;
/** 图片数量提示 */
@property (strong,nonatomic) UILabel *numberLabel;
/** 接收view */
@property (strong,nonatomic) UIView *acceptView;
/** 接受删除按钮 */
@property (strong,nonatomic) UIButton *acceptDeleBtn;


@end

@implementation PhotoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.textlable];
        [self addSubview:self.lineView];
        [self addSubview:self.addImageBtn];
        [self addSubview:self.numberLabel];
    }
    return self;
}

#pragma mark
#pragma mark - 约束
- (void)layoutSubviews {

    [super layoutSubviews];
    
    __weak typeof(self) weakself = self;

    [_textlable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.left).offset(10);
        make.top.equalTo(weakself.top).offset(10);
        
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.top).offset(44);
        make.left.equalTo(weakself.left).offset(10);
        make.centerX.equalTo(weakself.centerX);
        make.height.equalTo(1);
        
    }];
    
//    [_addImageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.top.equalTo(weakself.lineView.top).offset(10);
//        make.right.equalTo(weakself.right).offset(-10);
//        make.size.equalTo(CGSizeMake(111, 111));
//        
//    }];
    
    [_numberLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.lineView.bottom).offset(131);
        make.left.equalTo(weakself.left).offset(10);
        
    }];
    
}

#pragma mark
#pragma mark - 懒加载
- (UILabel *)textlable {

    if (!_textlable) {
        _textlable = [[UILabel alloc] init];
        _textlable.text = @"上传佐证";
        _textlable.font = [UIFont systemFontOfSize:16];
        _textlable.textColor = [UIColor colorWithHexString:@"#000000"];
    }
    return _textlable;
}

- (UIView *)lineView {

    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _lineView;
}

- (UIButton *)addImageBtn {

    if (!_addImageBtn) {

        _addImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addImageBtn setImage:[UIImage imageNamed:@"添加照片"] forState:UIControlStateNormal];
            _addImageBtn.layer.borderWidth = 1;
        _addImageBtn.layer.borderColor = [UIColor colorWithHexString:@"#99cc33"].CGColor;
        _addImageBtn.frame = CGRectMake(10, 54, (SCREEN_WIDTH - 40)/3, (SCREEN_WIDTH - 40)/3);
        [_addImageBtn addTarget:self action:@selector(clickAddPhoto:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addImageBtn;
}

- (UILabel *)numberLabel {

    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc] init];
        _numberLabel.text = @"请上传1-3张展示商家实力的图片";
        _numberLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _numberLabel.font = [UIFont systemFontOfSize:14];
    
        
    }
    return _numberLabel;
}

- (void)clickAddPhoto:(UIButton *)button {
    
    // 图片数量
    NSInteger cols = 3;
    
    CGFloat btnW = (SCREEN_WIDTH - (cols + 1) * kDogImageWidth) / cols;
    
    CGFloat btnH = btnW;
    
    CGFloat y = 54;
    
    CGFloat x = button.frame.origin.x;
    
    CGFloat rightX = kDogImageWidth + btnW;

    UIView * view = [[UIView alloc] init];
    view.frame = CGRectMake(kDogImageWidth, y, btnW, btnH);
    self.acceptView = view;
    
    UIButton * deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.acceptDeleBtn = deleteBtn;
    [deleteBtn setImage:[UIImage imageNamed:@"删除-拷贝-2"] forState:UIControlStateNormal];

    [deleteBtn setFrame:CGRectMake(view.frame.size.width - 12, 0, 12, 12)];
    
    [deleteBtn addTarget:self action:@selector(deleteImage:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView * imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(0, 0, btnW, btnH);
    imageView.image = [UIImage imageNamed:@"品种02"];

    [self.acceptView addSubview:imageView];
    [self.acceptView addSubview:deleteBtn];
    
    if (x < rightX) {
        
        view.frame = CGRectMake(kDogImageWidth, y, btnW, btnH);
        button.frame = CGRectMake(kDogImageWidth + rightX , y, btnW, btnH);

    } else if (x < 2 * rightX) {
    
        view.frame = CGRectMake(kDogImageWidth + rightX , y, btnW, btnH);
        button.frame = CGRectMake(kDogImageWidth + 2 * rightX , y, btnW, btnH);

    } else if (x < 3 * rightX) {
    
        view.frame = CGRectMake(kDogImageWidth + 2 * rightX , y, btnW, btnH);
   
        button.hidden = YES;
    }
    
    [self addSubview:self.acceptView];
}

- (void)deleteImage:(UIButton *)btn {

//    [self.acceptView removeFromSuperview];
//    self.addImageBtn.hidden = NO;

}

@end
