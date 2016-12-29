//
//  LivingToolView.h
//  GouGou-Live
//
//  Created by ma c on 16/12/9.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickBlackBtnAction)();
typedef void(^ClickShareBtnAction)(UIButton *btn);
typedef void(^ClickFaceOrBackBtnAction)();
@interface LivingToolView : UIView

@property(nonatomic, strong) ClickBlackBtnAction backBlcok; /**< 返回bloak */
@property(nonatomic, strong) ClickShareBtnAction shareBlcok; /**< 分享bloak */
@property(nonatomic, strong) ClickFaceOrBackBtnAction faceBlcok; /**< 翻转bloak */

@property (nonatomic, strong) NSString *watchPeople; /**< 观看人数 */


@end

