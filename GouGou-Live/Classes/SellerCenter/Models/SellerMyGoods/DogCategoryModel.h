//
//  DogCategoryModel.h
//  GouGou-Live
//
//  Created by ma c on 16/12/2.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "BaseModel.h"

@interface DogCategoryModel : BaseModel

@property(nonatomic, strong) NSString *name; /**< 名字 */
@property(nonatomic, strong) NSString *ID; /**< id */
@property(nonatomic, assign) NSInteger time; /**< 月数 */

@end
