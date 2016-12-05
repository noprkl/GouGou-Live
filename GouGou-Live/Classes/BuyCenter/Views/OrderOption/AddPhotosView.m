//
//  AddPhotosView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/16.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "AddPhotosView.h"

#import "UpLoadPictureView.h"

int counts = 0;

@interface AddPhotosView ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
/** 晒晒宝贝 */
@property (strong,nonatomic) UILabel *textLabel;
/** 添加图片 */
@property (strong,nonatomic) UIButton *addImageBtn;
/** 接收view */
@property (strong,nonatomic) UIView *acceptView;
/** 计数 */
@property (strong,nonatomic) UILabel *countLabel;
/** 接收图片 */
@property (strong,nonatomic) UIImageView *acceptImageView;
/** 系统相册 */
@property (strong,nonatomic) UIImagePickerController *picker;

@end


@implementation AddPhotosView

- (void)setPickers:(UIImagePickerController *)pickers {

    _pickers = pickers;
    self.picker = pickers;
}

#pragma mark
#pragma mark - 约束
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
       
        [self addSubview:self.addImageBtn];
        [self addSubview:self.textLabel];
        [self addSubview:self.countLabel];
        
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    __weak typeof(self) weakself = self;
    
    [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakself.right).offset(-10);
        make.bottom.equalTo(weakself.bottom).offset(-10);
        
    }];
}

- (UILabel *)textLabel {

    if (!_textLabel) {
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(89, 64, 100, 25)];
        _textLabel.font = [UIFont systemFontOfSize:14];
        _textLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _textLabel.text = @"晒晒小宝贝";
    }
    return _textLabel;
}

- (UILabel *)countLabel {

    if (!_countLabel) {
        _countLabel = [[UILabel alloc] init];
        _countLabel.textColor = [UIColor colorWithHexString:@"#666666"];
//        _countLabel.text = 
        _countLabel.font = [UIFont systemFontOfSize:14];
    }
    return _countLabel;
}

- (UIButton *)addImageBtn {
    
    if (!_addImageBtn) {
        
        _addImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addImageBtn setImage:[UIImage imageNamed:@"添加照片"] forState:UIControlStateNormal];
        _addImageBtn.layer.borderWidth = 1;
        _addImageBtn.layer.borderColor = [UIColor colorWithHexString:@"#99cc33"].CGColor;
        _addImageBtn.frame = CGRectMake(20, 20, (SCREEN_WIDTH - 60)/5, (SCREEN_WIDTH - 60)/5);
        [_addImageBtn addTarget:self action:@selector(clickAddPhoto:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addImageBtn;
}

- (UIImagePickerController *)picker {

    if (!_picker) {
        _picker = [[UIImagePickerController alloc] init];
        self.picker.delegate = self;
        self.picker.allowsEditing = YES;
    }
    return _picker;
}

- (void)clickAddPhoto:(UIButton *)button {
    
    if (_addPhotoBlock) {
     
//        UIImagePickerController  * picker = [[UIImagePickerController alloc] init];
//        
//        self.picker = picker;
//        self.picker.delegate = self;
//        self.picker.allowsEditing = YES;
       
//        [self.picker dismissViewControllerAnimated:YES completion:^{
//      
//        }];
    
        
        _addPhotoBlock(button);
        
    }
    
    counts++;
    
    self.countLabel.text = [NSString stringWithFormat:@"%d/7",counts];
    // 列数
    NSInteger margin = 5;
    
    //    // 图片数量
    //    NSInteger cols = 3;
    
    // 距离两侧距离
    NSInteger distance = 2 * kDogImageWidth;
    // 按钮宽
    CGFloat btnW = (SCREEN_WIDTH - 40 - (margin - 1) * kDogImageWidth) / margin;
    CGFloat labelW = self.textLabel.frame.size.width;
    // 按钮高度
    CGFloat btnH = btnW;
    CGFloat labelH = self.textLabel.frame.size.height;
    // 第一行y值
    CGFloat y = 20;
    CGFloat labY = y + 44;
    // 图片x值
    CGFloat x = button.frame.origin.x;
    // 参照值
    CGFloat rightX = kDogImageWidth + btnW;
    // 第二行y值
    CGFloat labY2 = labY + btnH + kDogImageWidth;
    // 第二行参照
    CGFloat boomtomY = y + btnH + kDogImageWidth;
    // 存放图片的View
    UIView * view = [[UIView alloc] init];
    view.frame = CGRectMake(kDogImageWidth, y, btnW, btnH);
    self.acceptView = view;
    // 图片
    UIImageView * imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(0, 0, btnW, btnH);
    //        imageView.image = [UIImage imageNamed:@"品种02"];
    
    self.acceptImageView = imageView;
    //        [self.acceptView addSubview:imageView];
    [view addSubview:imageView];
    
    if (button.frame.origin.y == y) {
        if (x < rightX) {
            
            view.frame = CGRectMake(distance, y, btnW, btnH);
            button.frame = CGRectMake(distance + rightX , y, btnW, btnH);
            self.textLabel.frame = CGRectMake(distance + 2 * rightX , labY, labelW, labelH);
            
        } else if (x < 2 * rightX) {
            
            view.frame = CGRectMake(distance + rightX , y, btnW, btnH);
            button.frame = CGRectMake(distance + 2 * rightX , y, btnW, btnH);
            self.textLabel.frame = CGRectMake(distance + 3 * rightX , labY, labelW, labelH);
            
        } else if (x < 3 * rightX) {
            
            view.frame = CGRectMake(distance + 2 * rightX , y, btnW, btnH);
            button.frame = CGRectMake(distance + 3 * rightX , y, btnW, btnH);
            self.textLabel.frame = CGRectMake(distance + 4 * rightX , labY, labelW, labelH);
        } else if (x < 4 * rightX) {
            
            view.frame = CGRectMake(distance + 3 * rightX , y, btnW, btnH);
            button.frame = CGRectMake(distance + 4 * rightX , y, btnW, btnH);
            
            self.textLabel.frame = CGRectMake(distance, labY2, labelW, labelH);
            
        } else if (x < 5 * rightX) {
            
            view.frame = CGRectMake(distance + 4 * rightX , y, btnW, btnH);
            button.frame = CGRectMake(distance , boomtomY, btnW, btnH);
            self.textLabel.frame = CGRectMake(distance + btnW , labY2, labelW, labelH);
            
        }
        
    } else if (button.frame.origin.y == boomtomY){
        if (x < rightX) {
            
            view.frame = CGRectMake(distance , boomtomY, btnW, btnH);
            button.frame = CGRectMake(distance +  rightX , boomtomY, btnW, btnH);
            //        self.textLabel.hidden = NO;
            self.textLabel.frame = CGRectMake(distance + 2 * rightX , labY2, labelW, labelH);
            
        } else if (x < 2 * rightX) {
            
            view.frame = CGRectMake(distance +  rightX , boomtomY, btnW, btnH);
            button.frame = CGRectMake(distance + 2 * rightX , boomtomY, btnW, btnH);
            self.textLabel.frame = CGRectMake(distance + 3 * rightX , labY2, labelW, labelH);
            
            button.enabled = NO;
            
        }
    }
    [self addSubview:view];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
       
    }];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    self.acceptImageView.image = image;
    
    DLog(@"%@",image);
   
}

@end
