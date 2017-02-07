//
//  PersonalPicturesVc.h
//  GouGou-Live
//
//  Created by 李祥起 on 2017/2/7.
//  Copyright © 2017年 LXq. All rights reserved.
//

#import "BaseViewController.h"
#import "MyAlbumsModel.h"

@interface PersonalPicturesVc : BaseViewController

@property (nonatomic, strong) NSString *userId; /**< 用户id */

@property(nonatomic, strong) MyAlbumsModel *model; /**< 模型 */

@end
