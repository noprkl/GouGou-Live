//
//  NonoDogTypesView.h
//  GouGou-Live
//
//  Created by 李祥起 on 2017/2/22.
//  Copyright © 2017年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickRequestButtonBlock)();

@interface NonoDogTypesView : UIView

@property (nonatomic, strong) ClickRequestButtonBlock requestBlock; /**< 重新加载 */

@end
