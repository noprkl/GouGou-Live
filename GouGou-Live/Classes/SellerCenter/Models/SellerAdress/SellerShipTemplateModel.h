//
//  SellerShipTemplateModel.h
//  GouGou-Live
//
//  Created by ma c on 16/12/23.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "BaseModel.h"

@interface SellerShipTemplateModel : BaseModel

@property (nonatomic, assign) NSInteger ID; /**< 模板id */
@property (nonatomic, assign) NSInteger addressId; /**< 地址id */
@property (nonatomic, strong) NSString *money; /**< 花费 */
@property (nonatomic, strong) NSString *name; /**< 模板名字 */

@end
