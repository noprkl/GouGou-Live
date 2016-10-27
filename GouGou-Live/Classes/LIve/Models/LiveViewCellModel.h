//
//  LiveViewCellModel.h
//  GouGou-Live
//
//  Created by ma c on 16/10/27.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LiveViewCellModel : NSObject

/** 主播头像 */
@property (strong, nonatomic) NSString *anchorIcon;

/** 主播名字 */
@property (strong, nonatomic) NSString *anchorName;

/** 定位城市 */
@property (strong, nonatomic) NSString *anchorCity;

/** 直播图 */
@property (strong, nonatomic) NSString *roomImage;

/** 房间信息 */
@property (strong, nonatomic) NSString *roomMessage;

@end
