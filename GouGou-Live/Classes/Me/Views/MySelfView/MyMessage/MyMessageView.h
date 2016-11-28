//
//  MyMessageView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/7.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ClickEditingControlBlcok)();
typedef void(^ClickLiveBtnBlcok)(NSString *btnTitle);
typedef void(^ClickFocusBtnBlcok)();
typedef void(^ClickFansBtnBlcok)();
typedef void(^ClickMyPageBtnBlcok)();

@interface MyMessageView : UIView

@property(nonatomic, strong) ClickEditingControlBlcok editBlock; /**< 粉丝回调 */
@property(nonatomic, strong) ClickFansBtnBlcok fansBlcok; /**< 粉丝回调 */
@property(nonatomic, strong) ClickFocusBtnBlcok focusBlcok; /**< 关注回调 */
@property(nonatomic, strong) ClickLiveBtnBlcok liveBlcok; /**< 直播回调 */
@property(nonatomic, strong) ClickMyPageBtnBlcok myPageBlcok; /**< 我的主页回调 */

@property(nonatomic, assign) NSInteger fansCount; /**< 粉丝数 */
@property(nonatomic, assign) NSInteger focusCount; /**< 关注数 */
@end
