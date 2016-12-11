//
//  LiveListRespModel.h
//  GouGou-Live
//
//  Created by Huimor on 16/12/10.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "BaseModel.h"

@interface LiveListRespModel : NSObject

@property (nonatomic, assign) NSInteger disabledTill; /**< disabled */
@property (nonatomic, strong) NSString * hub; /**< hubID */
@property (nonatomic, strong) NSString * key; /**< keyID */

@end
