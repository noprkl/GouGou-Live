//
//  LiveViewCellModel.h
//  GouGou-Live
//
//  Created by ma c on 16/10/27.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "BaseModel.h"

@interface LiveViewCellModel : BaseModel

/** 主播头像 */
//@property (strong, nonatomic) NSString *userImgUrl;

/** 主播名字 */
//@property (strong, nonatomic) NSString *userName;

//@property(nonatomic, strong) NSString *userId; /**< 用户id */

/** 房间名字 */
@property (strong, nonatomic) NSString *name;

/** 定位城市 */
//@property (strong, nonatomic) NSString *area;

//@property (nonatomic, strong) NSString *viewNum; /**< 观看人数 */

@property(nonatomic, strong) NSString *liveId; /**< 直播参数 */

@property(nonatomic, strong) NSArray *info; /**< 狗狗信息 */

@end
