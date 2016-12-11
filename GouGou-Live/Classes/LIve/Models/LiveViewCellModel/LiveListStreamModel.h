//
//  LiveListStreamModel.h
//  GouGou-Live
//
//  Created by Huimor on 16/12/10.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "BaseModel.h"

@interface LiveListStreamModel : NSObject

@property (nonatomic, strong) NSString * publish; /**< 推流地址 */
@property (nonatomic, strong) NSString * rtmp; /**< 拉流地址 */

@end
