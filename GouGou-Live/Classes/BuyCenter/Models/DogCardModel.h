//
//  DogCardModel.h
//  GouGou-Live
//
//  Created by ma c on 16/12/1.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "BaseModel.h"

@interface DogCardModel : BaseModel
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
@end
