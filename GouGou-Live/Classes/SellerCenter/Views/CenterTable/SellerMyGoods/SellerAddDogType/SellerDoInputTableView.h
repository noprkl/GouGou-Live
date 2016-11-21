//
//  SellerDoInputTableView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/20.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickSureAddButtonBlock)();

@interface SellerDoInputTableView : UITableView

@property(nonatomic, strong) ClickSureAddButtonBlock sureAddBlock; /**< 确认添加按钮 */


@end
