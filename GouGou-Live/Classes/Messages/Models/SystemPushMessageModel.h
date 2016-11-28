//
//  SystemPushMessageModel.h
//  GouGou-Live
//
//  Created by ma c on 16/11/28.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "BaseModel.h"

@interface SystemPushMessageModel : BaseModel

@property(nonatomic, strong) NSString *type; /**< 消息类别 */
@property(nonatomic, strong) NSString *conent; /**< 消息内容 */
@property(nonatomic, strong) NSString *createTime; /**< 创建时间 */
@property(nonatomic, strong) NSString *status; /**< 消息状态 */
@property(nonatomic, assign) NSInteger ID; /**< 消息类别 */

@end
