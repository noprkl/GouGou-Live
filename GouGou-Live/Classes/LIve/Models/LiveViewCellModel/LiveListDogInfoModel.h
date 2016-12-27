//
//  LiveListDogInfoModel.h
//  GouGou-Live
//
//  Created by ma c on 16/12/12.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "BaseModel.h"

@interface LiveListDogInfoModel : BaseModel

@property (nonatomic, strong) NSString *ID; /**< 商品ID */
@property (nonatomic, strong) NSString *name; /**< 狗狗名字 */
@property (nonatomic, strong) NSString *pathSmall; /**< 商品缩略图 */
@property (nonatomic, strong) NSString *dataPhoto; /**< 商品图 */
@property (nonatomic, strong) NSString *price; /**< 商品价格 */
@property (nonatomic, strong) NSString *priceOld; /**< 商品老价格 */
@property (nonatomic, strong) NSString *deposit; /**< 商品定金 */
@property (nonatomic, strong) NSString *agename; /**< 狗狗年龄 */
@property (nonatomic, strong) NSString *colorname; /**< 狗狗颜色 */
@property (nonatomic, strong) NSString *kindname; /**< 狗狗品种 */
@property (nonatomic, strong) NSString *sizename; /**< 狗狗体型 */
@property (nonatomic, strong) NSString *comment; /**< 补充 */
@property (nonatomic, strong) NSString *createTime; /**< 狗狗创建时间 */
@property (nonatomic, strong) NSString *impresssionId; /**< 狗狗印象 */
@property (nonatomic, strong) NSString *status; /**< 商品状态 */
@property (nonatomic, strong) NSString *traficMoney; /**< 运费 */

@end
