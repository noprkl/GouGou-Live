//
//  ShopAdressModel.h
//  GouGou-Live
//
//  Created by ma c on 16/11/4.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopAdressModel : NSObject

@property(nonatomic, strong) NSString *shopOwner; /**< 收货人 */

@property(nonatomic, strong) NSString *shopAdress; /**< 收货地址 */

@property(nonatomic, strong) NSString *shopPhone; /**< 联系电话 */

- (instancetype)getShopAdressWith:(NSString *)shopOwner shopAdress:(NSString *)shopAdress shopPhone:(NSString *)shopPhone;
@end
