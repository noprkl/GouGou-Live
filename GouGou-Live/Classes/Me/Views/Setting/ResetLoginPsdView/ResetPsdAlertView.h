//
//  ResetPsdAlertView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/10.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickSureBtnBlock)(NSString *text);

@interface ResetPsdAlertView : UIView

@property(nonatomic, strong) ClickSureBtnBlock sureBlock; /**< 确定回调 */

@property(nonatomic, strong) NSString *title; /**< 标题 */

@property(nonatomic, strong) NSString *placeHolder; /**< 占位字符 */
@property(nonatomic, strong) NSString *noteString; /**< 提示 */

- (void)show;
- (void)dismiss;

@end
