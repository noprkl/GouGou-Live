//
//  UpLoadPictureView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/14.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "UpLoadPictureView.h"

@interface UpLoadPictureView () <UIImagePickerControllerDelegate,UINavigationControllerDelegate>
/** 上传照片 */
@property (strong,nonatomic) UILabel *upLoadPicture;
/** 添加图片 */
@property (strong,nonatomic) UIButton *addImageBtn;
/** 接收view */
//@property (strong,nonatomic) UIImageView *acceptImageView;
@end

@implementation UpLoadPictureView

//- (void)setImageview:(UIImageView *)imageview {
//    
//    _imageview = imageview;
//    self.acceptImageView = imageview;
//
//}

#pragma mark
#pragma mark - 约束
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.upLoadPicture];
        [self addSubview:self.addImageBtn];
        
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    __weak typeof(self) weakself = self;
    
    [_upLoadPicture mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.left).offset(10);
        make.top.equalTo(weakself.top);
        
    }];
    
}

- (UILabel *)upLoadPicture {

    if (!_upLoadPicture) {
        _upLoadPicture = [[UILabel alloc] init];
        _upLoadPicture.text = @"上传照片（必填）";
        _upLoadPicture.textColor = [UIColor colorWithHexString:@"#333333"];
        _upLoadPicture.font = [UIFont systemFontOfSize:16];
    }
    return _upLoadPicture;
}

- (UIButton *)addImageBtn {
    
    if (!_addImageBtn) {
        
        _addImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addImageBtn setImage:[UIImage imageNamed:@"添加照片"] forState:UIControlStateNormal];
        _addImageBtn.layer.borderWidth = 1;
        _addImageBtn.layer.borderColor = [UIColor colorWithHexString:@"#99cc33"].CGColor;
        _addImageBtn.frame = CGRectMake(10, 30, (SCREEN_WIDTH - 40)/3, (SCREEN_WIDTH - 40)/3);
        [_addImageBtn addTarget:self action:@selector(clickAddPhoto:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addImageBtn;
}
- (void)clickAddPhoto:(UIButton *)button {
    
    if (_upLoadImageBlock) {
        _upLoadImageBlock(button);
    }



//    UIImagePickerController  * picker = [[UIImagePickerController alloc] init];
//
//    [picker dismissViewControllerAnimated:YES completion:^{
//        
//    }];

//    // 图片数量
//    NSInteger cols = 3;
//    
//    CGFloat btnW = (SCREEN_WIDTH - (cols + 1) * kDogImageWidth) / cols;
//    
//    CGFloat btnH = btnW;
//    
//    CGFloat y = 30;
//    
//    CGFloat x = button.frame.origin.x;
//    
//    CGFloat rightX = kDogImageWidth + btnW;
//    
//    UIView * view = [[UIView alloc] init];
//    view.frame = CGRectMake(kDogImageWidth, y, btnW, btnH);
////    self.acceptView = view;
//    
//    UIImageView * imageView = [[UIImageView alloc] init];
//    imageView.frame = CGRectMake(0, 0, btnW, btnH);
//
//    [view addSubview:imageView];
//    
//    if (x < rightX) {
//        
//        view.frame = CGRectMake(kDogImageWidth, y, btnW, btnH);
//        button.frame = CGRectMake(kDogImageWidth + rightX , y, btnW, btnH);
//        
//    } else if (x < 2 * rightX) {
//        
//        view.frame = CGRectMake(kDogImageWidth + rightX , y, btnW, btnH);
//        button.frame = CGRectMake(kDogImageWidth + 2 * rightX , y, btnW, btnH);
//        
//    } else if (x < 3 * rightX) {
//        
//        view.frame = CGRectMake(kDogImageWidth + 2 * rightX , y, btnW, btnH);
//        
//        button.hidden = YES;
//    }
//    
//    [self addSubview:view];
}

//-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
//    
//    
//    [picker dismissViewControllerAnimated:YES completion:^{
//        
//    }];
//    
//    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
//    
//    self.acceptImageView.image = image;
//    
//    DLog(@"%@",image);
//}

@end
