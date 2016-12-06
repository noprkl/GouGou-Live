//
//  SellerGoodsBarBtnView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/16.
//  Copyright © 2016年 LXq. All rights reserved.
//  自定义编辑添加按钮

#import <UIKit/UIKit.h>

typedef void(^ClickSellerAddBtnBlock)();
typedef void(^ClickSellerEditBtnBlock)(BOOL flag);

@interface SellerGoodsBarBtnView : UIView

@property(nonatomic, strong) ClickSellerAddBtnBlock addBlock; /**< 添加回调 */
@property(nonatomic, strong) ClickSellerEditBtnBlock editBlock; /**< 编辑回调 */

@end
