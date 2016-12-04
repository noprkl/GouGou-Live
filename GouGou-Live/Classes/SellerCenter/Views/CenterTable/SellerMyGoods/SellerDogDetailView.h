//
//  SellerDogDetailView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/19.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DogDetailModel.h"

@interface SellerDogDetailView : UIScrollView

@property(nonatomic, strong) DogDetailModel *dogInfo; /**< 订单数据数据 */

@end
