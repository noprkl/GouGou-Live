//
//  OrderDetailModel.h
//  GouGou-Live
//
//  Created by ma c on 16/12/1.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "BaseModel.h"

@interface OrderDetailModel : BaseModel
@property (copy, nonatomic) NSString *buyUserId;  /** 买家id */
@property (copy, nonatomic) NSString *buyUserName; /**< 买家姓名 */
@property (copy, nonatomic) NSString *buyUserTel; /**< 买家电话 */
@property (copy, nonatomic) NSString *recevieProvince; /**< 收货省份 */
@property (copy, nonatomic) NSString *recevieCity; /**< 收货城市 */
@property (copy, nonatomic) NSString *recevieDistrict; /**< 收货区 */
@property (copy, nonatomic) NSString *recevieAddress; /**< 收货地址 */

@property (copy, nonatomic) NSString *status; /**< 订单状态 */
@property (copy, nonatomic) NSString *closeTime; /**< 放弃定金时间 */

@property (copy, nonatomic) NSString *finalTime; /**< 时间 */
@property (copy, nonatomic) NSString *productDeposit; /**< 商品定金 */
@property (copy, nonatomic) NSString *productRealDeposit; /**< 商品实付定金 */
@property (copy, nonatomic) NSString *productBalance; /**< 商品尾款 */
@property (copy, nonatomic) NSString *productRealBalance; /**< 商品实付尾款 */
@property (copy, nonatomic) NSString *balancePayMethod; /**< 尾款支付方式 */
@property (copy, nonatomic) NSString *traficFee; /**< 运费 */
@property (copy, nonatomic) NSString *traficRealFee; /**< 实付运费 */

@property (copy, nonatomic) NSString *createTime; /**< 创建时间 */
@property (copy, nonatomic) NSString *depositTime; /**< 定金支付时间 */
@property (copy, nonatomic) NSString *balanceTime; /**< 尾款支付时间 */
@property (copy, nonatomic) NSString *deliveryTime; /**< 发货时间 */
@property (copy, nonatomic) NSString *userName; /**< 用户名 */

@property (copy,nonatomic) NSString *name; /**< 商品名称 */
@property (copy, nonatomic) NSString *pathSmall; /**< 缩略图 */
@property (copy,nonatomic) NSString *kindName; /**< 品种 */
@property (copy,nonatomic) NSString *ageName; /**< 狗狗年龄 */
@property (copy,nonatomic) NSString *sizeName; /**< 狗狗体型 */
@property (copy,nonatomic) NSString *colorName; /**< 狗狗颜色 */
@property (copy,nonatomic) NSString *priceOld; /**< 原价 */
@property (copy,nonatomic) NSString *price;  /**< 现价 */
@end
