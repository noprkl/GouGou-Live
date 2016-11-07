//
//  BaseHandler.m
//  GouGou-Live
//
//  Created by ma c on 16/11/7.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "BaseHandler.h"

@implementation BaseHandler

/** Handler处理完成后调用的Block */
typedef void(^CompleteBlock)();

/** Handler处理成功后调用的Block */
typedef void(^SuccessBlock)(id objc);

/** Handler处理失败后调用的Block */
typedef void(^FailedBlock)(NSError *error);


@end
