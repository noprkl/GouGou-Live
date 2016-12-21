//
//  LandscapePlayerToolView.h
//  GouGou-Live
//
//  Created by Huimor on 16/12/10.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickBlackButtonAction)();
typedef void(^ClickShareButtonAction)(UIButton *btn);
typedef void(^ClickcollectionButtonAction)(BOOL isCollection);
typedef void(^ClickReportButtonAction)();

@interface LandscapePlayerToolView : UIView

@property(nonatomic, strong) ClickBlackButtonAction backBlcok; /**< 返回bloak */
@property(nonatomic, strong) ClickShareButtonAction shareBlcok; /**< 分享bloak */
@property(nonatomic, strong) ClickReportButtonAction reportBlcok; /**< 举报bloak */
@property(nonatomic, strong) ClickcollectionButtonAction collectBlcok; /**< 收藏bloak */

@end
