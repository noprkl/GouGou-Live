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

+ (BOOL)validateCharacter:(NSString *)string;

/** 判断是否为中文 */
+ (BOOL)isChinese:(NSString *)string;

/** 判断是否为身份证号 */
- (BOOL)judgeIdentityStringValid:(NSString *)identityString;

/** 时间戳转时间 */
+ (NSString *)stringFromDateString:(NSString *)dateStr;
/** 播放时间转换 */
+ (NSString *)convertTime:(CGFloat)second;
/** 数字转年龄 */
+ (NSString *)getAgeFormInt:(NSInteger)age;
/** 根据文件名获得文件位置 */
+ (NSString *)cachePathWithfileName:(NSString *)filename;
/** 得到倒计时时间 */
+ (NSInteger)getRemainTimeWithString:(NSString *)createTime;
/** 得到当前的时间戳 */
+ (NSString *)getCurrentTime;
@end
