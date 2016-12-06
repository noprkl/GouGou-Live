//
//  SellerOrderDetailInfoView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/17.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickCopyBtnBlock)();

@interface SellerOrderDetailInfoView : UIView

@property(nonatomic, strong) ClickCopyBtnBlock copyBlock; /**< 复制回调 */


@property(nonatomic, strong) UILabel *orderCodeNumber; /**< 编号 */

@property(nonatomic, strong) UILabel *createTime; /**< 创建时间 */

@property(nonatomic, strong) UILabel *depositTime; /**< 定金支付时间 */

@property(nonatomic, strong) UILabel *finalMoneyTime; /**< 尾款支付时间 */

@property(nonatomic, strong) UILabel *sendTime; /**< 发货时间 */

@end
