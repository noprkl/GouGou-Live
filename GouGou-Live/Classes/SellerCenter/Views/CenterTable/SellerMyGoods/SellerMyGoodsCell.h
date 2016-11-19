//
//  SellerMyGoodsCell.h
//  GouGou-Live
//
//  Created by ma c on 16/11/16.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerBaseCell.h"

typedef void(^ClickSelectBtnBlock)(UIButton *btn);

@interface SellerMyGoodsCell : SellerBaseCell

@property(nonatomic, strong) NSArray *dogCard; /**< 狗Card */
@property(nonatomic, strong) NSString *cellState; /**< cell状态 */

@property(nonatomic, strong) ClickSelectBtnBlock selectBlock; /**< 多选按钮 */

@property(nonatomic, assign) BOOL isMove; /**< cell是否移动 */

@property(nonatomic, assign) BOOL isBtnSelect; /**< 按钮选中 */

@end
