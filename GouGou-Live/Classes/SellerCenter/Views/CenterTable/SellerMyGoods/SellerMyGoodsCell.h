//
//  SellerMyGoodsCell.h
//  GouGou-Live
//
//  Created by ma c on 16/11/16.
//  Copyright © 2016年 LXq. All rights reserved.
//  我的狗狗cell

#import "SellerBaseCell.h"
#import "SellerMyGoodsModel.h"

typedef void(^ClickSelectBtnBlock)(UIButton *btn);

@interface SellerMyGoodsCell : SellerBaseCell

@property(nonatomic, strong) SellerMyGoodsModel *model; /**< 我的狗狗模型 */

@property(nonatomic, strong) ClickSelectBtnBlock selectBlock; /**< 多选按钮 */

@property(nonatomic, assign) BOOL isMove; /**< cell是否移动 */

@property(nonatomic, assign) BOOL isBtnSelect; /**< 按钮选中 */

@end
