//
//  NSString+CertificateImage.m
//  GouGou-Live
//
//  Created by ma c on 16/11/28.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "NSString+CertificateImage.h"

@implementation NSString (CertificateImage)
// 图片转化字符串
+ (NSString *)imageBase64WithDataURL:(UIImage *)image  withSize:(CGSize)newSize
{
    CGFloat imageW = newSize.width;
    CGFloat imageH = newSize.height;
    UIGraphicsBeginImageContext(newSize);
    
    [image drawInRect:CGRectMake(0,0,imageW, imageH)];
    
    //开启上下文
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    NSData *imageData =nil;
    NSString *mimeType =nil;
    
    //图片要压缩的比例，此处100根据需求，自行设置
    CGFloat x = 500 / newImage.size.height;
    if (x > 2)
    {
        x = 2.0;
    }
    imageData = UIImageJPEGRepresentation(newImage, x);
    mimeType = @"image/jpeg";
    return [NSString stringWithFormat:@"data:%@;base64,%@", mimeType,
            [imageData base64EncodedStringWithOptions:0]];
}
// 图片转base64--原图大小
+ (NSString *)imageBase64WithDataURL:(UIImage *)image
{
    CGFloat imageW = image.size.width;
    CGFloat imageH = image.size.height;
    UIGraphicsBeginImageContext(CGSizeMake(imageW, imageH));
    
    [image drawInRect:CGRectMake(0,0,imageW, imageH)];
    
    //开启上下文
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    NSData *imageData =nil;
    NSString *mimeType =nil;
    
    //图片要压缩的比例，此处100根据需求，自行设置
    CGFloat x = 500 / newImage.size.height;
    if (x > 2)
    {
        x = 2.0;
    }
    imageData = UIImageJPEGRepresentation(newImage, x);
    mimeType = @"image/jpeg";
    return [NSString stringWithFormat:@"data:%@;base64,%@", mimeType,
            [imageData base64EncodedStringWithOptions:0]];
}

@end
