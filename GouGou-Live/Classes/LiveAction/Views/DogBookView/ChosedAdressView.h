//
//  ChosedAdressView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/4.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyShopAdressModel;
@class SellerAdressModel;
@interface ChosedAdressView : UIView


@property (nonatomic, strong) MyShopAdressModel *shopAdress; /**< 收货地址 */
@property (nonatomic, strong) SellerAdressModel *sellerAdress; /**< 发货地址 */


@property (nonatomic, assign) BOOL isHid; /**< 箭头是否隐藏 */

@end
