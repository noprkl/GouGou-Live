//
//  NSString+CheckString.h
//  GouGou-Live
//
//  Created by ma c on 16/10/26.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CheckString)

/** 判断手机号是否符合正则表达式 */
+ (BOOL)valiMobile:(NSString *)mobile;

/** 判读手机号是否是数字 */
+ (BOOL)validateNumber:(NSString*)number;

/** 判断是否为中文 */
- (BOOL)isChinese;

- (BOOL)judgeIdentityStringValid:(NSString *)identityString;
@end
