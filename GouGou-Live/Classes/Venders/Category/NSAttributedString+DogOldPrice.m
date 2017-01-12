//
//  NSAttributedString+DogOldPrice.m
//  GouGou-Live
//
//  Created by Huimor on 16/12/11.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "NSAttributedString+DogOldPrice.h"

@implementation NSAttributedString (DogOldPrice)

+ (NSAttributedString *)getCenterLineWithString:(NSString *)text {
    if (text.length == 0) {
        return nil;
    }else{
        NSDictionary *attribtDic = @{
                                     
                                     NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle],
                                     
                                     NSFontAttributeName:[UIFont systemFontOfSize:12],
                                     NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#999999"]
                                     
                                     };
        NSString *price = [NSString stringWithFormat:@"￥%@", text];
        NSAttributedString *attribut = [[NSAttributedString alloc] initWithString:text attributes:attribtDic];
        
        return attribut;
    }
}
@end
