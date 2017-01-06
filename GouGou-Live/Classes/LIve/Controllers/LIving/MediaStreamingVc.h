//
//  MediaStreamingVc.h
//  GouGou-Live
//
//  Created by ma c on 16/12/6.
//  Copyright © 2016年 LXq. All rights reserved.
//  直播 推流端 主播

#import "BaseViewController.h"
#import <PLMediaStreamingKit/PLMediaStreamingKit.h>


@interface MediaStreamingVc : BaseViewController

@property (nonatomic, strong) NSString *streamPublish; /**< 推流地址 */
@property (nonatomic, strong) NSString *streamRtmp; /**< 播放地址 */
@property (nonatomic, strong) PLStream *stream; /**< 流对象 */

@property (nonatomic, strong) NSString *liveID; /**< 直播参数 */

@property (nonatomic, strong) NSString *chatRoomID; /**< 直播房间id */

@property (nonatomic, assign) NSInteger shareType; /**< 分享类型 微博0 微信1 qq2 空间3 朋友圈4 */

@end
