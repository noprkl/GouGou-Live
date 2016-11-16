//
//  SellerGoodsBarBtnView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/16.
//  Copyright © 2016年 LXq. All rights reserved.
//  自定义编辑添加按钮

#import <UIKit/UIKit.h>

typedef void(^ClickEditBtnBlock)(BOOL flag);
typedef void(^ClickAddBtnBlock)();

@interface SellerGoodsBarBtnView : UIView

@property(nonatomic, strong) ClickAddBtnBlock addBlock; /**< 添加回调 */
@property(nonatomic, strong) ClickEditBtnBlock editBlock; /**< 编辑回调 */

@end
