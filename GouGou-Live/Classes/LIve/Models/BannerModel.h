//
//  BannerModel.h
//  GouGou-Live
//
//  Created by ma c on 16/12/24.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "BaseModel.h"
#import "LiveViewCellModel.h"

@interface BannerModel : BaseModel

@property (nonatomic, strong) NSString *img; /**< 图片 */
@property (nonatomic, strong) NSString *url; /**< 跳转地址 */
@property (nonatomic, assign) NSInteger type; /**< 跳转类型 0 html5跳转  1 直播跳转 */

//@property (nonatomic, strong) LiveViewCellModel *info; /**< 直播信息 */

@property (nonatomic, assign) NSInteger status; /**< 直播状态1.直播 3结束 */
@property (nonatomic, strong) NSString *liveId; /**< 直播参数 */
@property (nonatomic, strong) NSString *area; /**< 主播城市 */
@property (nonatomic, strong) NSString *ID; /**< 主播id */
@property (nonatomic, strong) NSString *merchantName; /**< 主播名字 */
@property (nonatomic, strong) NSString *name; /**< 房间名字 */
@property (nonatomic, strong) NSString *num; /**< 剩余商品数 */
@property (nonatomic, strong) NSString *pNum; /**< 商品数 */
@property (nonatomic, strong) NSString *snapshot; /**< 直播截图 */
@property (nonatomic, strong) NSString *userImgUrl; /**< 主播头像 */
@property (nonatomic, strong) NSString *viewNum; /**< 观看人数 */

@property (nonatomic, strong) NSString *chatroom; /**< 聊天id */


@end
