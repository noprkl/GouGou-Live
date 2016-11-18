//
//  AddPhotosView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/16.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ClickAddPhotoBtnBlock)(UIButton *button);

@interface AddPhotosView : UIView
/** 点击添加图片回调 */
@property (strong,nonatomic) ClickAddPhotoBtnBlock addPhotoBlock;
/** 接受picker */
@property (strong,nonatomic) UIImagePickerController *pickers;

@end
