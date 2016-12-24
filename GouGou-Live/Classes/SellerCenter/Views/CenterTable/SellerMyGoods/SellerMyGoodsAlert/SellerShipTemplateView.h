//
//  SellerShipTemplateView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/20.
//  Copyright © 2016年 LXq. All rights reserved.
//  运费模板选择弹窗

#import <UIKit/UIKit.h>
#import "SellerShipTemplateModel.h"

typedef void(^ClickSureButtonBlock)(SellerShipTemplateModel *style);

@interface SellerShipTemplateView : UITableView

/** detail数据 */
@property (strong, nonatomic) NSArray *detailPlist;

/** 点击cell回调 */
@property (strong, nonatomic) ClickSureButtonBlock sureBlock;

- (void)show;
- (void)dismiss;

@end
