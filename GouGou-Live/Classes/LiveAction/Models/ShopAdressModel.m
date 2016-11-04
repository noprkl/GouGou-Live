//
//  ShopAdressModel.m
//  GouGou-Live
//
//  Created by ma c on 16/11/4.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "ShopAdressModel.h"

@implementation ShopAdressModel

- (instancetype)getShopAdressWith:(NSString *)shopOwner shopAdress:(NSString *)shopAdress shopPhone:(NSString *)shopPhone {
   
    ShopAdressModel *adress = [[ShopAdressModel alloc] init];
    adress.shopAdress = shopAdress;
    adress.shopOwner = shopOwner;
    adress.shopPhone = shopPhone;
    
    return adress;
}
@end
