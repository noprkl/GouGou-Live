//
//  AcceptRateBuyerModel.h
//  GouGou-Live
//
//  Created by ma c on 16/12/2.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "BaseModel.h"

@interface AcceptRateBuyerModel : BaseModel

@property(nonatomic, strong) NSString *comment; /**< 评价内容 */
@property(nonatomic, strong) NSString *userNickName; /**< 买家昵称 */
@property(nonatomic, strong) NSString *userImgUrl; /**< 买家头像 */

@end
