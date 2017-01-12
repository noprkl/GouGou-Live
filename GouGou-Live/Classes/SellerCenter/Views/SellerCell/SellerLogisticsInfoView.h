//
//  SellerLogisticsInfoView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/15.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickSellerLogisticsEditBtnBlock)();

@interface SellerLogisticsInfoView : UIView

@property(nonatomic, assign) BOOL hidEdit; /**< 显示编辑按钮 */

@property(nonatomic, strong) ClickSellerLogisticsEditBtnBlock editBlock; /**< 点击编辑回调 */

@property (nonatomic, strong) NSString *transformNumber; /**< 运单编号 */
@property (nonatomic, strong) NSString *transformStyle; /**< 运货方式 */
@end
