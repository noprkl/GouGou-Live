//
//  PlayBackCard.h
//  GouGou-Live
//
//  Created by ma c on 16/11/2.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DogTypeCellModel;

@interface PlayBackCard : UIControl

@property(nonatomic, strong) DogTypeCellModel *dogCardModel; /**< 回放信息模型 */

@end
