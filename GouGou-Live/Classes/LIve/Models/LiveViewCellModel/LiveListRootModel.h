//
//  LiveListRootModel.h
//  GouGou-Live
//
//  Created by Huimor on 16/12/10.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "BaseModel.h"

@class LiveListRespModel;
@class LiveListStreamModel;
@interface LiveListRootModel : NSObject

@property (nonatomic, assign) NSInteger liveStatus;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) LiveListRespModel *resp;
@property (nonatomic, strong) LiveListStreamModel *steam;

@end
