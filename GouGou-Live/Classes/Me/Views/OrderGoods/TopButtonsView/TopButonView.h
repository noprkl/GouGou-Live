//
//  TopButonView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/10.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^ClickDifStateBlock)(NSInteger tag);

@interface TopButonView : UIView

/** 点击按钮回调 */
@property (strong,nonatomic) ClickDifStateBlock difStateBlock;
@end
