//
//  SystemPushMessageModel.h
//  GouGou-Live
//
//  Created by ma c on 16/11/28.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "BaseModel.h"

@interface SystemPushMessageModel : BaseModel

@property(nonatomic, strong) NSString *conent; /**< 消息内容 */
@property(nonatomic, strong) NSString *createTime; /**< 创建时间 */
@property(nonatomic, assign) NSInteger ID; /**< 消息类别 */
@property(nonatomic, strong) NSString *status; /**< 消息状态 0 未读 1 已读*/

@property(nonatomic, strong) NSString *type; /**< 消息类别 0不跳转 1商品 2订单*/

@property(nonatomic, strong) NSString *productId; /**< 商品id */
@property(nonatomic, strong) NSString *state; /**< 买家0还是卖家1 */

@property (nonatomic, strong) NSString *typeName; /**< 消息名字 */

@end
