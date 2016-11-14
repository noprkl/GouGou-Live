//
//  MyPageDescView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/14.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickEditBlock)();
@interface MyPageDescView : UIView

@property(nonatomic, strong) ClickEditBlock editBlock; /**< 编辑回调 */

@end
