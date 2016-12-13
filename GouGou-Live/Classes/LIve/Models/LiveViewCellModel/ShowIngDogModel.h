//
//  ShowIngDogModel.h
//  GouGou-Live
//
//  Created by ma c on 16/12/13.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "BaseModel.h"

@interface ShowIngDogModel : BaseModel

@property (nonatomic, assign) NSInteger ID; /**< 商品id */
@property (nonatomic, strong) NSString *pathSmall; /**< 商品图片 */
@property (nonatomic, strong) NSString *price; /**< 商品价格 */
@end
