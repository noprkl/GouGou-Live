//
//  DogImpressionModel.h
//  GouGou-Live
//
//  Created by ma c on 16/12/2.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "BaseModel.h"

@interface DogImpressionModel : BaseModel

@property(nonatomic, strong) NSString *name; /**< 印象 */

@property(nonatomic, strong) NSString *ID; /**< 印象id */

@property(nonatomic, strong) NSString *createTime; /**< <#注释#> */
@property(nonatomic, strong) NSString *createUser; /**< <#注释#> */
@property(nonatomic, strong) NSString *delFlg; /**< <#注释#> */
@property(nonatomic, strong) NSString *updateTime; /**< <#注释#> */
@property(nonatomic, strong) NSString *updateUser; /**< <#注释#> */

@end
