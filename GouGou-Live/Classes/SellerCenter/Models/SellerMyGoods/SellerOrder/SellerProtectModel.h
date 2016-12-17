//
//  SellerProtectModel.h
//  GouGou-Live
//
//  Created by ma c on 16/12/8.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "BaseModel.h"

@interface SellerProtectModel : BaseModel

@property (nonatomic, strong) NSString *ID; /**< 维权ID */

@property (copy, nonatomic) NSString *status; /**< 订单状态 */
@property (copy, nonatomic) NSString *closeTime; /**< 交易关闭时间 */

@property (copy, nonatomic) NSString *productRealPrice; /**< 商品实付价格 */
@property (copy, nonatomic) NSString *productRealDeposit; /**< 商品实付定金 */
@property (copy, nonatomic) NSString *productRealBalance; /**< 商品实付尾款 */
@property (copy, nonatomic) NSString *traficRealFee; /**< 商品实付运费 */

@property (copy, nonatomic) NSString *userNickName; /**< 用户昵称 */
@property (copy, nonatomic) NSString *userImgUrl; /**< 用户头像 */
@property (copy, nonatomic) NSString *buyUserId; /**< 用户id */

@property (copy, nonatomic) NSString *name; /**< 商品名称 */
@property (copy, nonatomic) NSString *pathSmall; /**< 缩略图 */
@property (copy, nonatomic) NSString *kindName; /**< 品种 */
@property (copy, nonatomic) NSString *ageName; /**< 狗狗年龄 */
@property (copy, nonatomic) NSString *sizeName; /**< 狗狗体型 */
@property (copy, nonatomic) NSString *colorName; /**< 狗狗颜色 */
@property (copy, nonatomic) NSString *priceOld; /**< 原价 */
@property (copy, nonatomic) NSString *price;  /**< 现价 */
@property (copy, nonatomic) NSString *comment;  /**< 评价 */
@property (copy, nonatomic) NSString *photoPath;  /**< 图片数组 */
@end
