//
//  ProtectPowerDetailModel.h
//  GouGou-Live
//
//  Created by ma c on 16/12/4.
//  Copyright © 2016年 LXq. All rights reserved.
//  维权详细

#import "BaseModel.h"

@interface ProtectPowerDetailModel : BaseModel

/** 买家昵称 */
@property (copy,nonatomic) NSString *userNickName;
/** 维权状态 */
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
@property (copy,nonatomic) NSString *productPrice;
/** 商品实付定金 */
@property (copy,nonatomic) NSString *productRealDeposit;
/** 商品实付尾款 */
@property (copy,nonatomic) NSString *productRealBalance;
/** 商品实付运费 */
@property (copy,nonatomic) NSString *traficRealFee;
/**< 评价内容 */
@property (copy, nonatomic) NSString *comment;
/**< 照片URL评价 */
@property (copy, nonatomic) NSString *photoPath;
@end
