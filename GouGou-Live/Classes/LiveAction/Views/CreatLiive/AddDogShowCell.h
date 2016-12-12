//
//  AddDogShowCell.h
//  GouGou-Live
//
//  Created by ma c on 16/12/8.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SellerMyGoodsModel.h"

typedef void(^ClickSelectButtonBlock)(UIButton *button);
typedef void(^ClickEditButtonBlock)();
typedef void(^ClickDeleteButtonBlock)();

@interface AddDogShowCell : UITableViewCell

@property(nonatomic, assign) BOOL isAllSelect; /**< 是否全选 */

@property (nonatomic, strong) SellerMyGoodsModel *model;

/** 点击'选中按钮'回调 */
@property (strong,nonatomic) ClickSelectButtonBlock selectBtnBlock;
/** 点击'编辑'回调 */
@property (strong,nonatomic) ClickEditButtonBlock editButtonBlock;
/** 点击'删除'回调 */
@property (strong,nonatomic) ClickDeleteButtonBlock deleteButtonBlock;

@end
