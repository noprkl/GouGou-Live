//
//  DeletePrommtView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/4.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CilckSureDeleteBtnBlock)(UIButton *button);

@interface DeletePrommtView : UIView

/** 点击确定按钮回调 */
@property (strong,nonatomic) CilckSureDeleteBtnBlock sureDeleteBtnBlock;

- (void)show;
- (void)dismiss;

@end
