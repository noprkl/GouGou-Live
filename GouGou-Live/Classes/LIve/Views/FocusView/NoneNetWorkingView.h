//
//  NoneNetWorkingView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/7.
//  Copyright © 2016年 LXq. All rights reserved.
//  没有网

#import <UIKit/UIKit.h>

typedef void(^ClickAddNetBtnBlock)();

@interface NoneNetWorkingView : UIView

@property(nonatomic, strong) ClickAddNetBtnBlock addNetBlock; /**< 点击加载回调 */

@end
