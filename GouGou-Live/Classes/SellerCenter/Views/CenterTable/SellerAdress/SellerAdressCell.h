//
//  SellerAdressCell.h
//  GouGou-Live
//
//  Created by ma c on 16/12/3.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickEditBtnBlock)();
typedef void(^ClickAcquiesceBtnBlock)(UIButton *btn);
typedef void(^ClickDeleteBteBlock)(UIButton * btn);

@class SellerAdressModel;
@interface SellerAdressCell : UITableViewCell

/** 点击编辑回调 */
@property (strong,nonatomic) ClickEditBtnBlock editBtnBlock;
/**< 默认按钮回调 */
@property(nonatomic, strong) ClickAcquiesceBtnBlock acquiesceBlock;
/** 点击删除按钮回调 */
@property (strong,nonatomic) ClickDeleteBteBlock deleteBlock;

@property(nonatomic, strong) SellerAdressModel *adressModel; /**< 模型 */

@end
