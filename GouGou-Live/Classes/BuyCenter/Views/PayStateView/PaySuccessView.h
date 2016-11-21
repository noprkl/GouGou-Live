//
//  PaySuccessView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/18.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickBackHomePage)(UIButton *btn);

@interface PaySuccessView : UIView
/** 点击返回首页回调 */
@property (strong,nonatomic) ClickBackHomePage backHomePageBlock;

@end
