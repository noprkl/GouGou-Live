//
//  DogDetailInfoModel.h
//  GouGou-Live
//
//  Created by ma c on 16/12/1.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "BaseModel.h"

@interface DogDetailInfoModel : BaseModel

@property(nonatomic, strong) NSString *ageName; /**< 年龄 */
@property(nonatomic, strong) NSString *colorName; /**< 颜色 */
@property(nonatomic, strong) NSString *ID; /**< id */
@property(nonatomic, strong) NSString *kindName; /**< 品种 */
@property(nonatomic, strong) NSString *name; /**< 名字 */
@property(nonatomic, strong) NSString *pathSmall; /**< 缩略图 */
@property(nonatomic, strong) NSString *price; /**< 价格 */
@property(nonatomic, strong) NSString *priceOld; /**< 老价格 */
@property(nonatomic, strong) NSString *sizeName; /**< 体型 */
@end
