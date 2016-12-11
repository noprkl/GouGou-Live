//
//  MediaStreamingVc.h
//  GouGou-Live
//
//  Created by ma c on 16/12/6.
//  Copyright © 2016年 LXq. All rights reserved.
//  直播 推流端 主播

#import "BaseViewController.h"

@interface MediaStreamingVc : BaseViewController

@property(nonatomic, strong) NSString *stremaURL; /**< 推流地址 */

@property (nonatomic, strong) NSArray *idArr; /**< 商品id数组 */

@end
