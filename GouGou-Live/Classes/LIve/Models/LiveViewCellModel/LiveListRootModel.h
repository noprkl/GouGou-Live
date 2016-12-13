//
//  LiveListRootModel.h
//  GouGou-Live
//
//  Created by Huimor on 16/12/10.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "BaseModel.h"

@class LiveRootStreamModel;
@interface LiveListRootModel : NSObject

@property (nonatomic, strong) NSArray *info; /**< 直播中狗狗信息 */

@property (nonatomic, strong) LiveRootStreamModel *steam; /**<  */

@end
