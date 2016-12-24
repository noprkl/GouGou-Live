//
//  BannerModel.h
//  GouGou-Live
//
//  Created by ma c on 16/12/24.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "BaseModel.h"

@interface BannerModel : BaseModel

@property (nonatomic, strong) NSString *img; /**< 图片 */
@property (nonatomic, strong) NSString *url; /**< 跳转地址 */

@end
