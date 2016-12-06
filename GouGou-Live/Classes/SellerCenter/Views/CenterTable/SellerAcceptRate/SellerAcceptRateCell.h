//
//  SellerAcceptRateCell.h
//  GouGou-Live
//
//  Created by ma c on 16/11/16.
//  Copyright © 2016年 LXq. All rights reserved.
//  卖家收到的评价cell

#import "SellerBaseCell.h"

@class SellerAccepeRateModel;
@interface SellerAcceptRateCell : SellerBaseCell

@property(nonatomic, strong) NSArray *images; /**< 狗狗图片数组 */


@property(nonatomic, strong) SellerAccepeRateModel *model; /**< 模型 */

@end
