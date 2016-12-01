//
//  FocusAndFansModel.h
//  GouGou-Live
//
//  Created by ma c on 16/11/28.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "BaseModel.h"

@interface FocusAndFansModel : BaseModel

@property(nonatomic, strong) NSString *userNickName; /**< 昵称 */

@property(nonatomic, strong) NSString *userMotto; /**< 个性签名 */

@property(nonatomic, strong) NSString *userImgUrl; /**< 头像 */

@property(nonatomic, assign) NSInteger userFanId; /**< 关注ID */

@end
