//
//  NSString+MD5Code.m
//  GouGou-Live
//
//  Created by ma c on 16/11/7.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "NSString+MD5Code.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (MD5Code)
+ (NSString *)md5WithString:(NSString *)input
{
    // 需要MD5加密的字符
    const char *cStr = [input UTF8String];
    // 设置字符加密后存储的空间
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    // 参数三：编码的加密机制
    CC_MD5(cStr, (UInt32)strlen(cStr), digest);
    
    NSMutableString *result = [[NSMutableString alloc] initWithCapacity:16];
    
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i ++) {
        
        [result appendFormat:@"%2s",digest];
        
    }
    
    return result;
}
@end