//
//  PersonalMessageModel.h
//  GouGou-Live
//
//  Created by ma c on 16/12/21.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "BaseModel.h"

@interface PersonalMessageModel : BaseModel

@property (nonatomic, strong) NSString *isMerchant; /**< 商家认证状态 */
@property (nonatomic, strong) NSString *isReal; /**< 实名认证 */
@property (nonatomic, strong) NSString *merchantName; /**< 商家名字 */
@property (nonatomic, strong) NSString *userImgUrl; /**< 用户头像 */
@property (nonatomic, strong) NSString *userMotto; /**< 用户签名 */
@property (nonatomic, strong) NSString *userName; /**< 用户实名 */

@end
