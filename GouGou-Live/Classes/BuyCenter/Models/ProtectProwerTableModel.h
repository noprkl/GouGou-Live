//
//  ProtectProwerTableModel.h
//  GouGou-Live
//
//  Created by ma c on 16/12/2.
//  Copyright © 2016年 LXq. All rights reserved.
//  维权列表

#import "BaseModel.h"

@interface ProtectProwerTableModel : BaseModel

// 订单ID
@property (nonatomic, strong) NSString *ID;
/** 商家图片 */
@property (copy,nonatomic) NSString *userImgUrl;
/** 商家名称 */
@property (copy,nonatomic) NSString *userName;

@property (nonatomic, strong) NSString *saleUserId; /**< 卖家id */

/** 订单状态 */
@property (copy,nonatomic) NSString *status;

/** 商品名称 */
@property (copy,nonatomic) NSString *name;
/** 缩略图 */
@property (copy, nonatomic) NSString *pathSmall;
/** 品种 */
@property (copy,nonatomic) NSString *kindName;
/** 狗狗年龄 */
@property (copy,nonatomic) NSString *ageName;
/** 狗狗体型 */
@property (copy,nonatomic) NSString *sizeName;
/** 狗狗颜色 */
@property (copy,nonatomic) NSString *colorName;
/** 原价 */
@property (copy,nonatomic) NSString *priceOld;
/** 现价 */
@property (copy,nonatomic) NSString *price;

/** 商品实际价格 */
@property (copy,nonatomic) NSString *productRealPrice;
/** 实付实收定金 */
@property (copy,nonatomic) NSString *productRealDeposit;
/** 商品实收尾款 */
@property (copy,nonatomic) NSString *productRealBalance;
/** 运费 */
@property (copy,nonatomic) NSString *traficRealFee;

@property (copy, nonatomic) NSString *closeTime; /**< 维权关闭时间 */

@property (nonatomic, strong) NSString *transportation; /**< 快递方式 */
@property (nonatomic, strong) NSString *waybillNumber; /**< 快递方式 */

@end
