//
//  SellerDogOnSailAlertView.h
//  GouGou-Live
//
//  Created by 李祥起 on 2017/2/9.
//  Copyright © 2017年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickSureButtonBlock)();
typedef void(^ClickCancelButtonBlock)();
@interface SellerDogOnSailAlertView : UIView

@property (nonatomic, strong) ClickSureButtonBlock sureBlock; /**< 确定 */
@property (nonatomic, strong) ClickCancelButtonBlock cancelBlock; /**< 取消 */
@property (nonatomic, strong) NSString *message; /**< 提示信息 */

- (void)show;
@end
