//
//  UserAssetModel.h
//  GouGou-Live
//
//  Created by ma c on 16/12/2.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "BaseModel.h"

@interface UserAssetModel : BaseModel

@property(nonatomic, strong) NSString *assetChange; /**< 金额变化 */
@property(nonatomic, strong) NSString *assetChangeTime; /**< 交易时间 */
@property(nonatomic, strong) NSString *assetChangeType; /**< 交易类型 */
@property(nonatomic, strong) NSString *nowAsset; /**< 交易后账户 */
@property(nonatomic, strong) NSString *oldAsset; /**< 交易前账户 */
@property(nonatomic, strong) NSString *remark; /**< 交易信息 */

@end
