//
//  CostModel.h
//  GouGou-Live
//
//  Created by ma c on 16/12/1.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "BaseModel.h"

@interface CostModel : BaseModel

/** 商品实际价格 */
@property (copy,nonatomic) NSString *productRealDeposit;
/** 商品尾款 */
@property (copy,nonatomic) NSString *balance;

@property (copy, nonatomic) NSString *traficRealFee; /**< 运费 */

@end
