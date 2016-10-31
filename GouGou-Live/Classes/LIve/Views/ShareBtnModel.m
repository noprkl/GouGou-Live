//
//  ShareBtnModel.m
//  GouGou-Live
//
//  Created by ma c on 16/10/31.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "ShareBtnModel.h"

@implementation ShareBtnModel

- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image
{
    ShareBtnModel *model = [[ShareBtnModel alloc] init];
    model.title = title;
    model.icon = image;
    
    return model;
}
@end
