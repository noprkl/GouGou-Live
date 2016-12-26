//
//  HostLiveModel.h
//  GouGou-Live
//
//  Created by ma c on 16/12/18.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "BaseModel.h"

@interface HostLiveModel : BaseModel
/** 人数 */
@property (copy,nonatomic) NSString *viewNum;

/** 直播参数 */
@property (copy,nonatomic) NSString *liveId;

/** 狗狗简介 */
@property (copy,nonatomic) NSString *name;

/** 主播名字 */
@property (strong, nonatomic) NSString *userNickName;
/** 主播头像 */
@property (strong, nonatomic) NSString *userImgUrl;


/** 主播ID */
@property (strong, nonatomic) NSString *userId;


@property (nonatomic, assign) NSInteger pNum; /**< 商品数量 */

@property (nonatomic, assign) NSInteger num; /**< 剩余数量 */

@property (nonatomic, strong) NSString *snapshot; /**< 直播头像 */
@property (nonatomic, strong) NSString *chatroom; /**< 聊天室id */

@property (nonatomic, strong) NSString *status; /**< 状态 */

@end
