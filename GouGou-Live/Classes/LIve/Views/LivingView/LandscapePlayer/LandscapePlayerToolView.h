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

@property(nonatomic, strong) UIButton *backBtn; /**< 返回按钮 */

@property(nonatomic, strong) UIImageView *livingImageView; /**< 直播提示图 */

@property(nonatomic, strong) UIButton *watchCount; /**< 观看人数 */

@property(nonatomic, strong) UIButton *reportBtn; /**< 举报 */

@property(nonatomic, strong) UIButton *shareBtn; /**< 分享 */

@property(nonatomic, strong) UIButton *collectBtn; /**< 收藏按钮 */

@property(nonatomic, strong) ClickBlackButtonAction backBlcok; /**< 返回bloak */
@property(nonatomic, strong) ClickShareButtonAction shareBlcok; /**< 分享bloak */
@property(nonatomic, strong) ClickReportButtonAction reportBlcok; /**< 举报bloak */
@property(nonatomic, strong) ClickcollectionButtonAction collectBlcok; /**< 收藏bloak */

@end
