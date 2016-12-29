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
@property (nonatomic, strong) NSString *money; /**< 花费 */
@property (nonatomic, strong) NSString *name; /**< 模板名字 */
@property (nonatomic, assign) NSInteger isDefault; /**< 是否模板 */
@property (nonatomic, assign) NSInteger type; /**< 模板类型 0运费模版 1免运费 2按时计算 */

@property (nonatomic, assign) NSInteger addressId; /**< 地址id */
@property (nonatomic, strong) NSString *merchantAddress; /**< 发货详细地址 */
@property (nonatomic, strong) NSString *merchantCity; /**< 发货市 */
@property (nonatomic, strong) NSString *street; /**< 发货街道 */
@property (nonatomic, strong) NSString *merchantDistrict; /**< 发货区 */
@property (nonatomic, strong) NSString *merchantProvince; /**< 发货省 */
@property (nonatomic, strong) NSString *merchantTel; /**< 发货联系人 */
@property (nonatomic, strong) NSString *merchantName; /**< 发货联系人 */

@end
