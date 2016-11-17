//
//  SellerOrderDetailInfoView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/17.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickCopyBtnBlock)();

@interface SellerOrderDetailInfoView : UIView

@property(nonatomic, strong) ClickCopyBtnBlock copyBlock; /**< 复制回调 */

@end
