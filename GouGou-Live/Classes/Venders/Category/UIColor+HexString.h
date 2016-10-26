//
//  UIColor+HexString.h
//  GouGou-Live
//
//  Created by ma c on 16/10/26.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexString)

/** 16进制转RGB */
+ (UIColor *)colorWithHexString:(NSString *)color;
@end
