//
//  CostModel.h
//  GouGou-Live
//
//  Created by ma c on 16/12/1.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "BaseModel.h"

@interface CostModel : BaseModel
/** 商品定金 */
//@property (copy,nonatomic) NSString *productDeposit;
/** 实付定金 */
@property (copy,nonatomic) NSString *productRealDeposit;
/** 商品尾款 */
@property (copy,nonatomic) NSString *balance;
/** 实付尾款 */
//@property (copy,nonatomic) NSString *realLalance;
/** 总计 */
@property (copy, nonatomic) NSString *totalPrice;

@end
