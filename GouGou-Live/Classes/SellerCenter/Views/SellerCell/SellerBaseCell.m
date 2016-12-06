//
//  SellerBaseCell.m
//  GouGou-Live
//
//  Created by ma c on 16/11/15.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerBaseCell.h"

@implementation SellerBaseCell

- (NSAttributedString *)getCenterLineWithString:(NSString *)text {
    NSDictionary *attribtDic = @{
                                 NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle],
                                 NSFontAttributeName:[UIFont systemFontOfSize:12],
                                 NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#999999"]
                                 };
    NSAttributedString *attribut = [[NSAttributedString alloc] initWithString:text attributes:attribtDic];
    return attribut;
}

@end
