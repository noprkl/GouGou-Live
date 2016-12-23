//
//  DogDetailModel.h
//  GouGou-Live
//
//  Created by ma c on 16/12/4.
//  Copyright © 2016年 LXq. All rights reserved.
//  狗狗详情model

#import "BaseModel.h"

@interface DogDetailModel : BaseModel

@property(nonatomic, strong) NSString *name; /**< 名字 */
@property(nonatomic, strong) NSString *pathBig; /**< 图片 */
@property(nonatomic, assign) NSInteger age; /**< 年龄 */
@property(nonatomic, strong) DogCategoryModel *color; /**< 颜色 */
@property(nonatomic, strong) DogCategoryModel *kind; /**< 品种 */
@property(nonatomic, strong) DogCategoryModel *size; /**< 体型 */
@property(nonatomic, strong) NSArray *impresssion; /**< 印象 */
@property(nonatomic, strong) NSString *comment; /**< 补充 */
@property(nonatomic, strong) NSString *price; /**< 价格 */
@property(nonatomic, strong) NSString *ID; /**< 商品ID */
@property(nonatomic, strong) NSString *status; /**< 商品状态 */
@property(nonatomic, strong) NSString *createTime; /**< 创建时间 */

@end
