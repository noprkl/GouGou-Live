//
//  LiveListDogInfoModel.h
//  GouGou-Live
//
//  Created by ma c on 16/12/12.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "BaseModel.h"

@interface LiveListDogInfoModel : BaseModel

@property(nonatomic, assign) NSInteger ID; /**< 商品ID */

@property(nonatomic, strong) NSString *pathSmall; /**< 商品缩略图 */
@property(nonatomic, assign) NSInteger preice; /**< 商品价格 */

@property (nonatomic, strong) NSString *name; /**< 狗狗名字 */

@end
