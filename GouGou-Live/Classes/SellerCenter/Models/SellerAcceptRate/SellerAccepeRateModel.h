//
//  SellerAccepeRateModel.h
//  GouGou-Live
//
//  Created by ma c on 16/12/2.
//  Copyright © 2016年 LXq. All rights reserved.
//  卖家收到的评价

#import "BaseModel.h"

@interface SellerAccepeRateModel : BaseModel

@property(nonatomic, strong) NSString *ageName; /**< 狗的年龄 */
@property(nonatomic, strong) NSString *colorName; /**< 颜色 */
@property(nonatomic, strong) NSString *sizeName; /**< 狗狗体型 */
@property(nonatomic, strong) NSString *ID; /**< 狗狗id */
@property(nonatomic, strong) NSString *kindName; /**< 品种 */
@property(nonatomic, strong) NSString *name; /**< 名字 */
@property(nonatomic, strong) NSString *pathSmall; /**< 狗狗缩略图 */
@property(nonatomic, strong) NSString *photoPath; /**< 图片 */
@property(nonatomic, strong) NSString *userImgUrl; /**< 买家头像 */
@property(nonatomic, strong) NSString *userName; /**< 买家昵称 */
@property(nonatomic, strong) NSString *comment; /**< 评价内容 */

@property (nonatomic, strong) NSString *price; /**< 商品价格 */
@property (nonatomic, strong) NSString *priceOld; /**< 商品老价格 */

@property(nonatomic, strong) NSString *createTime; /**< 评价时间 */

@property (nonatomic, assign) NSInteger point; /**< 评分 */

@end
