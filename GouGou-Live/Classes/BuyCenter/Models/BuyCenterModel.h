//
//  BuyCenterModel.h
//  GouGou-Live
//
//  Created by ma c on 16/12/1.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "BaseModel.h"

@interface BuyCenterModel : BaseModel

@property (strong,nonatomic) NSString *ID;/** 订单ID */

@property (copy,nonatomic) NSString *userImgUrl;/**< 商家图片 */

@property (copy,nonatomic) NSString *userName;/**< 商家名称 */

@property (copy,nonatomic) NSString *status;/**< 订单状态 */

@property (copy,nonatomic) NSString *name;/**< 商品名称 */

@property (copy, nonatomic) NSString *pathSmall;/**< 缩略图 */

@property (copy,nonatomic) NSString *kindName;/**< 品种 */

@property (copy,nonatomic) NSString *ageName;/**< 狗狗年龄 */

@property (copy,nonatomic) NSString *sizeName;/**< 狗狗体型 */

@property (copy,nonatomic) NSString *colorName;/**< 狗狗颜色 */

@property (copy,nonatomic) NSString *priceOld;/**< 原价 */
@property (copy,nonatomic) NSString *price;/**< 现价 */
@property (nonatomic, strong) NSString *saleUserId; /**< 卖家id */

@property (copy,nonatomic) NSString *productDeposit;/**< 商品定金 */
@property (copy,nonatomic) NSString *productBalance;/** 商品尾款 */

@property (copy,nonatomic) NSString *productRealDeposit;/**< 实付定金 */
@property (copy,nonatomic) NSString *productRealBalance;/** 实付尾款 */

/** 商品总价 */
@property (copy,nonatomic) NSString *productPrice;
@property (copy,nonatomic) NSString *productRealPrice;/** 实付金额 */

@property (nonatomic, strong) NSString *comment; /**< 补充 */

@property (nonatomic, strong) NSString *traficFee; /**< 运费 */
@property (nonatomic, strong) NSString *createTime; /**< 订单创建时间 */
@property (nonatomic, strong) NSString *closeTime; /**< 订单创建时间 */

@property (nonatomic, strong) NSString *transportation; /**< 快递方式 */
@property (nonatomic, strong) NSString *waybillNumber; /**< 快递方式 */

@end
