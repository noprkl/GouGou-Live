//
//  SearchFanModel.h
//  GouGou-Live
//
//  Created by ma c on 16/12/23.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "BaseModel.h"

@interface SearchFanModel : BaseModel
@property(nonatomic, strong) NSString *userNickName; /**< 昵称 */

@property(nonatomic, strong) NSString *userMotto; /**< 个性签名 */

@property(nonatomic, strong) NSString *userImgUrl; /**< 头像 */

@property(nonatomic, strong) NSString *ID; /**< 关注ID */

@property (nonatomic, strong) NSString *state; /**< 是否关注 */

@end
