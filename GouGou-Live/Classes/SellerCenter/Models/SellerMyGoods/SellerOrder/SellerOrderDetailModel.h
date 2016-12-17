//
//  SellerOrderDetailModel.h
//  GouGou-Live
//
//  Created by ma c on 16/12/5.
//  Copyright © 2016年 LXq. All rights reserved.
//  订单详情

#import "BaseModel.h"

@interface SellerOrderDetailModel : BaseModel

@property (copy, nonatomic) NSString *buyUserId;  /** 买家流水号 */
@property (copy, nonatomic) NSString *buyUserName; /**< 买家姓名 */
@property (copy, nonatomic) NSString *buyUserTel; /**< 买家电话 */
@property (copy, nonatomic) NSString *recevieProvince; /**< 买家所在省份 */
@property (copy, nonatomic) NSString *recevieCity; /**< 买家所在市、区 */
@property (copy, nonatomic) NSString *recevieDistrict; /**< 买家所在区、县 */
@property (copy, nonatomic) NSString *recevieAddress; /**< 买家地址 */

@property (copy, nonatomic) NSString *status; /**< 维权状态 */
@property (copy, nonatomic) NSString *statusWq; /**< 订单状态 */
@property (copy, nonatomic) NSString *closeTime; /**< 交易关闭时间 */

@property (copy, nonatomic) NSString *finalTime; /**< 维权截止时间 */
@property (copy, nonatomic) NSString *productDeposit; /**< 商品定金 */
@property (copy, nonatomic) NSString *productRealDeposit; /**< 商品实付定金 */
@property (copy, nonatomic) NSString *productBalance; /**< 商品尾款 */
@property (copy, nonatomic) NSString *productRealBalance; /**< 商品实付尾款 */
@property (copy, nonatomic) NSString *balancePayMethod; /**< 尾款支付方式 */
@property (copy, nonatomic) NSString *traficFee; /**< 商品运费 */
@property (copy, nonatomic) NSString *traficRealFee; /**< 商品实付运费 */

@property (copy, nonatomic) NSString *createTime; /**< 创建时间 */
@property (copy, nonatomic) NSString *depositTime; /**< 定金支付时间 */
@property (copy, nonatomic) NSString *balanceTime; /**< 尾款支付时间 */
@property (copy, nonatomic) NSString *deliveryTime; /**< 发货时间 */
@property (copy, nonatomic) NSString *userName; /**< 用户昵称 */

@property (copy, nonatomic) NSString *name; /**< 商品名称 */
@property (copy, nonatomic) NSString *pathSmall; /**< 缩略图 */
@property (copy, nonatomic) NSString *kindName; /**< 品种 */
@property (copy, nonatomic) NSString *ageName; /**< 狗狗年龄 */
@property (copy, nonatomic) NSString *sizeName; /**< 狗狗体型 */
@property (copy, nonatomic) NSString *colorName; /**< 狗狗颜色 */
@property (copy, nonatomic) NSString *priceOld; /**< 原价 */
@property (copy, nonatomic) NSString *price;  /**< 现价 */

@end
