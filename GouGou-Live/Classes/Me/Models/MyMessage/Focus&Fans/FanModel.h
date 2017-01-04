//
//  FanModel.h
//  GouGou-Live
//
//  Created by ma c on 16/12/30.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "BaseModel.h"

@interface FanModel : BaseModel

@property(nonatomic, strong) NSString *userNickName; /**< 昵称 */

@property(nonatomic, strong) NSString *userMotto; /**< 个性签名 */

@property(nonatomic, strong) NSString *userImgUrl; /**< 头像 */

@property(nonatomic, assign) NSInteger userFanId; /**< 关注ID */

@property (nonatomic, strong) NSString *state; /**< 是否关注 */


@end
