//
//  SellerAdressModel.h
//  GouGou-Live
//
//  Created by ma c on 16/12/3.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "BaseModel.h"

@interface SellerAdressModel : BaseModel

@property(nonatomic, strong) NSString *merchantName; /**< 收货人姓名 */
@property(nonatomic, assign) NSInteger ID; /**< 商家地址id */
@property(nonatomic, strong) NSString *merchantAddress; /**< 详细地址 */
@property(nonatomic, strong) NSString *merchantDistrict; /**< 所在区县 */
@property(nonatomic, strong) NSString *merchantCity; /**< 所在市区 */
@property(nonatomic, strong) NSString *merchantProvince; /**< 所在省份 */
@property(nonatomic, assign) NSInteger isDefault; /**< 是否为默认地址 */
@property(nonatomic, strong) NSString *merchantTel; /**< 收货人手机号 */
@property(nonatomic, strong) NSString *createUser; /**< 收货人手机号 */

@end
