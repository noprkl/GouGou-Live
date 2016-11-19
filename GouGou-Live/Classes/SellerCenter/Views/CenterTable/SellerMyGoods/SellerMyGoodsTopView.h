//
//  ReviewMyGoodsTopView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/16.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickAllBlock)();
typedef void(^ClickWaitSellBlock)();
typedef void(^ClickSlodBlock)();
typedef void(^ClickReviewBlock)();

@interface SellerMyGoodsTopView : UIView

/** 全部 */
@property (strong, nonatomic) ClickAllBlock allBlock;
/** 待售 */
@property (strong, nonatomic) ClickWaitSellBlock waitSellBlock;
/** 已售 */
@property (strong, nonatomic) ClickSlodBlock soldBlock;
/** 审核 */
@property (strong, nonatomic) ClickReviewBlock reviewBlock;

@property(nonatomic, assign) BOOL canClick; /**< 是否能点击 */

@end
