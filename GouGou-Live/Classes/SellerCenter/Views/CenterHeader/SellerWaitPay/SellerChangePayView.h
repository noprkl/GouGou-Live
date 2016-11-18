//
//  SellerChangePayView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/18.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClicktextFieldBlock)();

@interface SellerChangePayView : UIView

@property(nonatomic, strong) ClicktextFieldBlock editBlock; /**< 文本回调 */

@end
