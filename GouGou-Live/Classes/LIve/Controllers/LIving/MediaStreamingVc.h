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

//@property (nonatomic, strong) NSArray *idArr; /**< 商品id数组 */
//
//@property(nonatomic, strong) NSString *roomStr; /**< 房间名 */
//
//@property(nonatomic, strong) NSString *city; /**< 主播城市 */
//

@property (nonatomic, strong) NSString *streamPublish; /**< 推流地址 */
@property (nonatomic, strong) NSString *streamRtmp; /**< 播放地址 */
@property (nonatomic, strong) PLStream *stream; /**< 流对象 */

@property (nonatomic, strong) NSString *liveID; /**< 直播参数 */

@property (nonatomic, strong) NSString *chatRoomID; /**< 直播房间id */

@end
