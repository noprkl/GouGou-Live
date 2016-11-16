//
//  SellerMyGoodsTopView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/16.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickTalkBlock)();
typedef void(^ClickDogBlock)();
typedef void(^ClickServiceBlock)();
typedef void(^ClickSellerBlock)();

@interface SellerMyGoodsTopView : UIView

/** 全部 */
@property (strong, nonatomic) ClickTalkBlock allBlock;
/** 待售 */
@property (strong, nonatomic) ClickDogBlock waitSellBlock;
/** 已售 */
@property (strong, nonatomic) ClickServiceBlock soldBlock;
/** 审核 */
@property (strong, nonatomic) ClickSellerBlock reviewBlock;

@end
