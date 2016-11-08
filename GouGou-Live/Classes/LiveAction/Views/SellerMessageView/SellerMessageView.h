//
//  SellerMessageView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/1.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickFocusBtnBlock)();
@interface SellerMessageView : UIView


@property(nonatomic, strong) ClickFocusBtnBlock focusBlock; /**< 关注回调 */

- (CGFloat)getMessageHeight;

@end
