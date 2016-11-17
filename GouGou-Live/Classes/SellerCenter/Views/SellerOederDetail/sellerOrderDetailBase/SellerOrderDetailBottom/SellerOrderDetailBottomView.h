//
//  SellerOrderDetailBottomView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/17.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickButtonBlock)(NSString *btnTitle);
@interface SellerOrderDetailBottomView : UIView

@property(nonatomic, strong) NSArray *btnTitles; /**< 按钮标题数组 */

@property(nonatomic, strong) ClickButtonBlock clickBlock; /**< 点击回调 */

@end
