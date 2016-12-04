//
//  SellerMyGoodsModel.h
//  GouGou-Live
//
//  Created by ma c on 16/12/2.
//  Copyright © 2016年 LXq. All rights reserved.
//  我的宝贝model

#import "BaseModel.h"

@interface SellerMyGoodsModel : BaseModel

@property(nonatomic, strong) NSString *name; /**< 名字 */
@property(nonatomic, strong) NSString *pathSmall; /**< 图片 */
@property(nonatomic, strong) NSString *ageName; /**< 年龄 */
@property(nonatomic, strong) NSString *colorName; /**< 颜色 */
@property(nonatomic, strong) NSString *kindName; /**< 品种 */
@property(nonatomic, strong) NSString *sizeName; /**< 体型 */
@property(nonatomic, strong) NSString *comment; /**< 补充 */
@property(nonatomic, strong) NSString *price; /**< 价格 */
@property(nonatomic, strong) NSString *priceOld; /**< 原价 */
@property(nonatomic, strong) NSString *ID; /**< 商品ID */
@property(nonatomic, strong) NSString *status; /**< 商品状态 */
@property(nonatomic, strong) NSString *createTime; /**< 创建时间 */

@end
