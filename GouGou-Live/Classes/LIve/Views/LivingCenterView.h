//
//  LivingCenterView.h
//  GouGou-Live
//
//  Created by ma c on 16/10/28.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef BOOL(^ClickTalkBlock)(UIButton *btn);
typedef BOOL(^ClickDogBlock)(UIButton *btn);
typedef BOOL(^ClickServiceBlock)(UIButton *btn);
typedef BOOL(^ClickSellerBlock)(UIButton *btn);

@interface LivingCenterView : UIView

/** 聊天 */
@property (strong, nonatomic) ClickTalkBlock talkBlock;
/** 狗狗 */
@property (strong, nonatomic) ClickDogBlock dogBlock;
/** 客服 */
@property (strong, nonatomic) ClickServiceBlock serviceBlock;
/** 认证商家 */
@property (strong, nonatomic) ClickSellerBlock sellerBlock;
@end
