//
//  SellerDogCardView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/15.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DogCardModel.h"

@interface SellerDogCardView : UIView

@property(nonatomic, strong) NSArray *dogCard; /**< 狗Card */
/** 狗狗信息模型 */
@property (strong,nonatomic) DogCardModel *dogCardModel;

@end
