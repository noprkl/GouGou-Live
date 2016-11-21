//
//  UpLoadPictureView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/14.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickUploadImageBlock)(UIButton *button);

@interface UpLoadPictureView : UIView
/** 上传照片回调 */
@property (strong,nonatomic) ClickUploadImageBlock upLoadImageBlock;
//@property (strong,nonatomic) UIImageView *imageview;

@end
