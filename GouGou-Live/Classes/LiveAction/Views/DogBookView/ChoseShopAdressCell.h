//
//  ChoseShopAdressCell.h
//  GouGou-Live
//
//  Created by ma c on 16/11/4.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyShopAdressModel;
@class SellerAdressModel;

@interface ChoseShopAdressCell : UITableViewCell

@property(nonatomic, strong) SellerAdressModel *sendAdress; /**< 发货地址 */
@property(nonatomic, strong) MyShopAdressModel *acceptAdress; /**< 收货地址 */

@end
