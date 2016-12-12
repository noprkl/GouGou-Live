//
//  CerfificateFaildView.h
//  GouGou-Live
//
//  Created by ma c on 16/12/12.
//  Copyright © 2016年 LXq. All rights reserved.
//  审核失败，重新提交信息

#import <UIKit/UIKit.h>

typedef void(^ClickBackBtnBlcok)();
typedef void(^ClickRecommitBtnBlock)();
@interface CerfificateFaildView : UIView

@property (nonatomic, strong) ClickBackBtnBlcok backBlcok; /**< 返回 */

@property (nonatomic, strong) ClickRecommitBtnBlock recommitBlock; /**< 重新提交信息 */

@end
