//
//  OrderDetailModel.h
//  GouGou-Live
//
//  Created by ma c on 16/12/1.
//  Copyright © 2016年 LXq. All rights reserved.
//  买家订单详细

#import "BaseModel.h"

@interface OrderDetailModel : BaseModel

@property (nonatomic, strong) NSString *ID; /**< 订单id */
@property (copy, nonatomic) NSString *buyUserName; /**< 买家姓名 */
@property (copy, nonatomic) NSString *buyUserTel; /**< 买家电话 */
@property (copy, nonatomic) NSString *recevieProvince; /**< 买家所在省份 */
@property (copy, nonatomic) NSString *recevieCity; /**< 买家所在市、区 */
@property (copy, nonatomic) NSString *recevieDistrict; /**< 买家所在区、县 */
@property (copy, nonatomic) NSString *recevieAddress; /**< 买家地址 */

@property (copy, nonatomic) NSString *status; /**< 订单状态 */
@property (copy, nonatomic) NSString *closeTime; /**< 交易关闭时间 */

@property (copy, nonatomic) NSString *finalTime; /**< 维权截止时间 */
@property (copy, nonatomic) NSString *productDeposit; /**< 商品定金 */
@property (copy, nonatomic) NSString *productRealDeposit; /**< 商品实付定金 */
@property (copy, nonatomic) NSString *productBalance; /**< 商品尾款 */
@property (copy, nonatomic) NSString *productRealBalance; /**< 商品实付尾款 */
@property (copy, nonatomic) NSString *productPrice; /**< 订单总价 */
@property (copy, nonatomic) NSString *productRealPrice; /**< 商品实付款 */

@property (copy, nonatomic) NSString *balancePayMethod; /**< 尾款支付方式 */

@property (copy, nonatomic) NSString *traficFee; /**< 商品运费 */
@property (copy, nonatomic) NSString *traficRealFee; /**< 商品实付运费 */

@property (copy, nonatomic) NSString *createTime; /**< 创建时间 */
@property (copy, nonatomic) NSString *depositTime; /**< 定金支付时间 */
@property (copy, nonatomic) NSString *balanceTime; /**< 尾款支付时间 */
@property (copy, nonatomic) NSString *deliveryTime; /**< 发货时间 */
@property (copy, nonatomic) NSString *userName; /**< 用户昵称 */
@property (copy, nonatomic) NSString *userImgUrl; /**< 商家头像 */
@property (nonatomic, strong) NSString *saleUserId; /**< 卖家id */

@property (copy, nonatomic) NSString *merchantName; /**< 商家名字 */
@property (copy, nonatomic) NSString *name; /**< 商品名称 */
@property (copy, nonatomic) NSString *pathSmall; /**< 缩略图 */
@property (copy, nonatomic) NSString *kindName; /**< 品种 */
@property (copy, nonatomic) NSString *ageName; /**< 狗狗年龄 */
@property (copy, nonatomic) NSString *sizeName; /**< 狗狗体型 */
@property (copy, nonatomic) NSString *colorName; /**< 狗狗颜色 */
@property (copy, nonatomic) NSString *priceOld; /**< 原价 */
@property (copy, nonatomic) NSString *price;  /**< 现价 */

@property (nonatomic, strong) NSString *transportation; /**< 快递方式 */
@property (nonatomic, strong) NSString *waybillNumber; /**< 快递方式 */

@property (nonatomic, strong) NSString *orderId; /**< 订单编号 */

@end
