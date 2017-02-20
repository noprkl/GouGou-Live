//
//  MyUnLoginView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/7.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickLoginBtnBlcok)();
typedef void(^ClickLiveButtonBlcok)();

@interface MyUnLoginView : UIView

@property(nonatomic, strong) ClickLoginBtnBlcok loginBlcok; /**< 登录 */

@property (nonatomic, strong) ClickLiveButtonBlcok liveBlock; /**< 直播 */

@end
