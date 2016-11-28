//
//  MyShopAdressModel.h
//  GouGou-Live
//
//  Created by ma c on 16/11/24.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "BaseModel.h"

@interface MyShopAdressModel : BaseModel
@property(nonatomic, strong) NSString *userName; /**< 收货人姓名 */
@property(nonatomic, assign) NSInteger ID; /**< 地址id */
@property(nonatomic, strong) NSString *userAddress; /**< 详细地址 */
@property(nonatomic, strong) NSString *userDistrict; /**< 所在区县 */
@property(nonatomic, strong) NSString *userCity; /**< 所在市区 */
@property(nonatomic, strong) NSString *userProvince; /**< 所在省份 */
@property(nonatomic, assign) NSInteger isDefault; /**< 是否为默认地址 */
@property(nonatomic, strong) NSString *userTel; /**< 收货人手机号 */

@end
