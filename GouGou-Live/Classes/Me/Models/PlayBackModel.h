//
//  PlayBackModel.h
//  GouGou-Live
//
//  Created by ma c on 16/12/20.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "BaseModel.h"

@interface PlayBackModel : BaseModel

@property (nonatomic, strong) NSString *ID; /**< 主播id */
@property (nonatomic, strong) NSString *liveId; /**< 直播id */
@property (nonatomic, strong) NSString *merchantName; /**< 商家名字 */
@property (nonatomic, strong) NSString *name; /**< 房间名字 */
@property (nonatomic, assign) NSInteger pNum; /**< 商品数量 */
@property (nonatomic, strong) NSString *snapshot; /**< 直播截图 */
@property (nonatomic, strong) NSString *userImgUrl; /**< 头像 */
@property (nonatomic, strong) NSString *viewNum; /**< 观看人数 */
@property (nonatomic, strong) NSString *createTime; /**< 直播时间 */
@property (nonatomic, assign) NSInteger num; /**< 剩余的数量 */

@end
