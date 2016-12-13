//
//  DogBookViewController.h
//  GouGou-Live
//
//  Created by ma c on 16/11/3.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "BaseViewController.h"
#import "LiveListDogInfoModel.h"

@interface DogBookViewController : BaseViewController

@property(nonatomic, strong) LiveListDogInfoModel *model; /**< 模型 */
@property (nonatomic, strong) NSString *liverID; /**< 直播id */
@property (nonatomic, strong) NSString *liverIcon; /**< 主播头像 */
@property (nonatomic, strong) NSString *liverName; /**< 主播名字 */
@property (nonatomic, strong) NSString *userId; /**< 主播id */

@end
