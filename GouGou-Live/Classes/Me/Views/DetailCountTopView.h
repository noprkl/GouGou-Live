//
//  DetailCountTopView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/1.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef BOOL(^ClickTalkBlock)(UIButton *btn);
typedef BOOL(^ClickDogBlock)(UIButton *btn);
typedef BOOL(^ClickServiceBlock)(UIButton *btn);
typedef BOOL(^ClickSellerBlock)(UIButton *btn);

@interface DetailCountTopView : UIView

/** 全部 */
@property (strong, nonatomic) ClickTalkBlock talkBlock;
/** 支出 */
@property (strong, nonatomic) ClickDogBlock dogBlock;
/** 收益 */
@property (strong, nonatomic) ClickServiceBlock serviceBlock;
/** 交易中 */
@property (strong, nonatomic) ClickSellerBlock sellerBlock;
@end
