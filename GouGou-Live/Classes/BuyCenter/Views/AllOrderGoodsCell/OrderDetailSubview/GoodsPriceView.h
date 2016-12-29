//
//  GoodsPriceView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/13.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsPriceView : UIView
@property (copy, nonatomic) NSString *productDeposit; /**< 商品定金 */
@property (copy, nonatomic) NSString *productRealDeposit; /**< 商品实付定金 */
@property (copy, nonatomic) NSString *productBalance; /**< 商品尾款 */
@property (copy, nonatomic) NSString *productRealBalance; /**< 商品实付尾款 */
@property (copy, nonatomic) NSString *balancePayMethod; /**< 尾款支付方式 */
@property (copy, nonatomic) NSString *traficFee; /**< 商品运费 */
@property (copy, nonatomic) NSString *traficRealFee; /**< 商品实付运费 */
@property (copy, nonatomic) NSString *totalsMoney; /**< 商品总价 */
@property (copy, nonatomic) NSString *cutMoney; /**< 优惠 */

@end
