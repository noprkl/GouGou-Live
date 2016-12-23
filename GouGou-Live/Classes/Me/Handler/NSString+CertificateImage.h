//
//  NSString+CertificateImage.h
//  GouGou-Live
//
//  Created by ma c on 16/11/28.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CertificateImage)

/** 图片转base64 */
+ (NSString *)imageBase64WithDataURL:(UIImage *)image  withSize:(CGSize)newSize;
@end
