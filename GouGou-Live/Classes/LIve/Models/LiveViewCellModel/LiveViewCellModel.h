//
//  LiveViewCellModel.h
//  GouGou-Live
//
//  Created by ma c on 16/10/27.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "BaseModel.h"

@interface LiveViewCellModel : BaseModel

@property (strong, nonatomic) NSString *userImgUrl;/**< 主播头像 */

@property (strong, nonatomic) NSString *merchantName;/**< 主播名字 */

@property(nonatomic, strong) NSString *ID; /**< 用户id */

@property (strong, nonatomic) NSString *name;/**< 房间名字 */

@property (strong, nonatomic) NSString *area;/**< 定位城市 */

@property (nonatomic, strong) NSString *viewNum; /**< 观看人数 */
@property(nonatomic, strong) NSString *liveId; /**< 直播参数 */

@property (nonatomic, assign) NSInteger pNum; /**< 商品数量 */

@property (nonatomic, strong) NSString *snapshot; /**< 直播图片 */
@property (nonatomic, strong) NSString *chatroom; /**< 聊天室id */

@property (nonatomic, strong) NSString *status; /**< 直播状态 */

@end
