//
//  LiveRootStreamModel.h
//  GouGou-Live
//
//  Created by ma c on 16/12/13.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "BaseModel.h"

@class LiveListRespModel;
@class LiveListStreamModel;

@interface LiveRootStreamModel : BaseModel
@property (nonatomic, assign) NSInteger liveStatus;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) LiveListRespModel *resp;
@property (nonatomic, strong) LiveListStreamModel *steam;

@end
