//
//  SellerDoInputCell.h
//  GouGou-Live
//
//  Created by ma c on 16/11/20.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickSureAddBtnBlock)();

@interface SellerDoInputCell : UITableViewCell

@property(nonatomic, strong) ClickSureAddBtnBlock sureAddBlock; /**< 确认添加按钮 */

@property(nonatomic, strong) DogCategoryModel *model; /**< 模型 */

@end
