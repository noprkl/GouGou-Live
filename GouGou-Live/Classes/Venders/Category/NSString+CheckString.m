//
//  NSString+CheckString.m
//  GouGou-Live
//
//  Created by ma c on 16/10/26.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "NSString+CheckString.h"

@implementation NSString (CheckString)
//判断手机号码格式是否正确
+ (BOOL)valiMobile:(NSString *)mobile {
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11)
    {
        return NO;
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
}
// 判断是否是数字
+ (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i,1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length ==0) {
            res =NO;
            break;
        }
        i++;
    }
    return res;
}
// 判断是否为中文
+ (BOOL)isChinese:(NSString *)string
{
//    unichar c = [string characterAtIndex:0];
//    if (c >= 0x4E00 && c <= 0x9FFF)
//    {
//        return YES;
//    }
//    else
//    {
//        return NO;
//    }
    return YES;
}

+ (BOOL)validateCharacter:(NSString *)string {
    const char *cStr = [string UTF8String];
    if (strlen(cStr) == 1) {
        return YES;
    }
    return NO;
}

// 判断身份证号是否正确
- (BOOL)judgeIdentityStringValid:(NSString *)identityString {
    
    if (identityString.length != 18) return NO;
    // 正则表达式判断基本 身份证号是否满足格式
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(![identityStringPredicate evaluateWithObject:identityString]) return NO;
    
    //** 开始进行校验 *//
    
    //将前17位加权因子保存在数组里
    NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    
    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
    NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    
    //用来保存前17位各自乖以加权因子后的总和
    NSInteger idCardWiSum = 0;
    for(int i = 0;i < 17;i++) {
        NSInteger subStrIndex = [[identityString substringWithRange:NSMakeRange(i, 1)] integerValue];
        NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
        idCardWiSum+= subStrIndex * idCardWiIndex;
    }
    
    //计算出校验码所在数组的位置
    NSInteger idCardMod=idCardWiSum%11;
    //得到最后一位身份证号码
    NSString *idCardLast= [identityString substringWithRange:NSMakeRange(17, 1)];
    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
    if(idCardMod==2) {
        if(![idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]) {
            return NO;
        }
    }
    else{
        //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
        if(![idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
            return NO;
        }
    }
    return YES;
}
+ (NSString *)stringFromDateString:(NSString *)dateStr {
    // 时间戳转时间
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[dateStr intValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"YY-MM-dd HH:mm";
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}
// 时间
+ (NSString *)convertTime:(CGFloat)second {
    // 相对格林时间
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:second];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    if (second / 3600 >= 1) {
        [formatter setDateFormat:@"HH:mm:ss"];
    } else {
        [formatter setDateFormat:@"mm:ss"];
    }
    
    NSString *showTimeNew = [formatter stringFromDate:date];
    return showTimeNew;
}
+ (NSString *)getAgeFormInt:(NSInteger)age {
    NSArray *mouthArr = @[@"0个月", @"1个月", @"2个月", @"3个月", @"4个月", @"5个月", @"6个月", @"7个月", @"8个月", @"9个月", @"10个月", @"11个月", @"12个月"];
    NSArray *yearArr = @[@"0岁", @"1岁", @"2岁", @"3岁", @"4岁", @"5岁", @"6岁", @"7岁"];
    NSInteger mouthIndex = age % 12;
    NSInteger yearIndex = age / 12;
    NSString *mouth = mouthArr[mouthIndex];
    NSString *year = yearArr[yearIndex];
    NSString *ageText;
    if (age < 12) {
        ageText = [NSString stringWithFormat:@"%@", mouth];
    }else if (age == 12){
        ageText = @"1岁";
    }else{
        ageText = [NSString stringWithFormat:@"%@%@", year, mouth];
    }
    return ageText;
}

+ (NSString *)cachePathWithfileName:(NSString *)filename {
    
    return [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", filename]];
}

// 根据订单创建时间获得订单的倒计时数
+ (NSInteger)getRemainTimeWithString:(NSString *)closeTime {
    
    NSDate *date = [NSDate date];// 当前时间
//    NSDateFormatter *formate = [[NSDateFormatter alloc] init];
//    formate.dateFormat = @"YYMMddHHmmss";
//    NSString *formatDate = [formate stringFromDate:date];
    NSString *timeSp = [NSString stringWithFormat:@"%.0f", [date timeIntervalSince1970]];

    // 时间差 剩余时间 关闭时间-当前时间
    if (closeTime.length > 10) {
        closeTime = [closeTime substringWithRange:NSMakeRange(0, 10)];
    }
    NSInteger timeLast = [closeTime integerValue] - [timeSp integerValue];
    return timeLast;
}
// 得到当前的时间戳
+ (NSString *)getCurrentTime{
    NSDate *date = [NSDate date];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"YYYYMMddHHmmss";
    NSString *time = [format stringFromDate:date];
    return time;
}
@end
