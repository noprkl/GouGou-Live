//
//  DogCardView.h
//  GouGou-Live
//
//  Created by ma c on 16/10/27.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiveListDogInfoModel.h"

@interface DogCardView : UIControl

@property(nonatomic, strong) NSString *message; /**< 右下的信息 */

@property (nonatomic, strong) NSString *imageName; /**< 背景图片 */

@property (nonatomic, strong) LiveListDogInfoModel *dogInfo; /**< 狗狗信息 */

@end
