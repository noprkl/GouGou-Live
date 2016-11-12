//
//  DeletePrommtView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/4.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CilckSureDeleteBtnBlock)(UIButton *button);
typedef void(^CilckCancelBtnBlock)();
@interface DeletePrommtView : UIView

/** 点击确定按钮回调 */
@property (strong,nonatomic) CilckSureDeleteBtnBlock sureDeleteBtnBlock;

@property(nonatomic, strong) CilckCancelBtnBlock cancelBlock; /**< 取消回调 */

@property(nonatomic, strong) NSString *message; /**< 提示信息 */

- (void)show;
- (void)dismiss;

@end
